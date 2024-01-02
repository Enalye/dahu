/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module atelier.cli.cli_export;

import std.conv : to;
import std.datetime;
import std.exception;
import std.file;
import std.path;
import std.stdio;

import grimoire;
import atelier.common;
import atelier.core;
import atelier.script;

void cliExport(Cli.Result cli) {
    if (cli.hasOption("help")) {
        writeln(cli.getHelp(cli.name));
        return;
    }

    string atelierPath = buildNormalizedPath(dirName(thisExePath()), Atelier_Exe);
    enforce(atelierPath, "impossible de trouver `" ~ atelierPath ~ "`");

    string dir = getcwd();
    string dirBaseName = baseName(dir);

    if (cli.optionalParamCount() >= 1) {
        enforce(isValidPath(cli.getOptionalParam(0)), "chemin non valide");
        dirBaseName = baseName(cli.getOptionalParam(0));
        dir = buildNormalizedPath(dir, cli.getOptionalParam(0));
    }
    enforce(!extension(dirBaseName).length, "le nom du projet ne peut pas être un fichier");

    string projectFile = buildNormalizedPath(dir, Atelier_Project_File);
    enforce(exists(projectFile),
        "aucun fichier de project `" ~ Atelier_Project_File ~
        "` de trouvé à l’emplacement `" ~ dir ~ "`");

    Json json = new Json(projectFile);

    string sourceFile;
    string configName = json.getString(Atelier_Project_DefaultConfiguration_Node, "");

    if (cli.hasOption("config")) {
        configName = cli.getOption("config").getRequiredParam(0);
    }

    Json[] configsNode = json.getObjects(Atelier_Project_Configurations_Node, []);
    foreach (Json configNode; configsNode) {
        if (configNode.getString(Atelier_Project_Name_Node, "") == configName) {
            sourceFile = buildNormalizedPath(dir, configNode.getString(Atelier_Project_Source_Node));

            enforce(exists(sourceFile),
                "le fichier source `" ~ sourceFile ~ "` référencé dans `" ~
                Atelier_Project_File ~ "` n’existe pas");

            string exportDir = buildNormalizedPath(dir,
                configNode.getString(Atelier_Project_Export_Node));

            if (!exists(exportDir))
                mkdir(exportDir);

            string newAtelierPath = buildNormalizedPath(exportDir, setExtension(configName, "exe"));
            std.file.copy(atelierPath, newAtelierPath);

            string envPath = buildNormalizedPath(exportDir,
                setExtension(configName, Atelier_Environment_Extension));

            Json[string] resourcesNode = configNode.getObject(Atelier_Project_Resources_Node)
                .getChildren();
            string[] archives;

            ResourceManager res = new ResourceManager;
            setupDefaultResourceLoaders(res);

            foreach (string resName, Json resNode; resourcesNode) {
                string resFolder = buildNormalizedPath(dir, resNode.getString("path", resName));
                enforce(exists(resFolder), "le dossier de ressources `" ~ resFolder ~
                        "` référencé dans `" ~ Atelier_Project_File ~ "` n’existe pas");

                Archive archive = new Archive;
                archive.pack(resFolder);
                if (resNode.getBool("archived", true)) {
                    string resDir = buildNormalizedPath(exportDir,
                        setExtension(resName, Atelier_Archive_Extension));
                    writeln("Archivage de `" ~ resFolder ~ "` vers `", resDir, "`");

                    foreach (file; archive) {
                        if (extension(file.name) == Atelier_Resource_Extension) {
                            OutStream stream = new OutStream;
                            stream.write!string(Atelier_Resource_Compiled_MagicWord);

                            Json resJson = new Json(file.data);
                            Json[] resNodes = resJson.getObjects("resources", []);

                            stream.write!uint(cast(uint) resNodes.length);
                            foreach (resNode; resNodes) {
                                string resType = resNode.getString("type");
                                stream.write!string(resType);

                                ResourceManager.Loader loader = res.getLoader(resType);
                                loader.compile(dirName(file.path), resNode, stream);
                            }

                            file.name = setExtension(file.name, Atelier_Resource_Compiled_Extension);
                            file.data = cast(ubyte[]) stream.data;
                        }
                    }

                    archive.save(resDir);
                    archives ~= setExtension(resName, Atelier_Archive_Extension);
                }
                else {
                    string resDir = buildNormalizedPath(exportDir, resName);
                    writeln("Copie de `" ~ resFolder ~ "` vers `", resDir, "`");
                    archive.unpack(resDir);
                    archives ~= resName;
                }
            }

            Json windowNode = configNode.getObject(Atelier_Project_Window_Node);
            string windowTitle = windowNode.getString(Atelier_Project_Window_Title_Node, configName);
            int windowWidth = windowNode.getInt(Atelier_Project_Window_Width_Node,
                Atelier_Window_Width_Default);
            int windowHeight = windowNode.getInt(Atelier_Project_Window_Height_Node,
                Atelier_Window_Height_Default);
            string windowIcon = windowNode.getString(Atelier_Project_Window_Icon_Node, "");
            bool windowEnabled = windowNode.getBool(Atelier_Project_Window_Enabled_Node,
                Atelier_Window_Enabled_Default);

            if (windowIcon.length) {
                std.file.copy(buildNormalizedPath(dir, windowIcon),
                    buildNormalizedPath(exportDir, windowIcon));
            }

            foreach (fileName; [
                    Atelier_StandardLibrary_Path, "SDL2.dll", "SDL2_image.dll",
                    "SDL2_ttf.dll", "OpenAL32.dll"
                ]) {
                string filePath = buildNormalizedPath(dirName(thisExePath()), fileName);
                enforce(exists(filePath), "fichier manquant `" ~ filePath ~ "`");

                std.file.copy(filePath, buildNormalizedPath(exportDir, fileName));
            }

            string bytecodePath = buildNormalizedPath(exportDir,
                setExtension(configName, Atelier_Bytecode_Extension));

            {
                OutStream envStream = new OutStream;
                envStream.write!string(Atelier_Environment_MagicWord);
                envStream.write!size_t(Atelier_Version_ID);
                envStream.write!bool(windowEnabled);

                if (windowEnabled) {
                    envStream.write!string(windowTitle);
                    envStream.write!uint(windowWidth);
                    envStream.write!uint(windowHeight);
                    envStream.write!string(windowIcon);
                }

                envStream.write!size_t(archives.length);
                foreach (string archive; archives) {
                    envStream.write!string(archive);
                }
                std.file.write(envPath, envStream.data);
            }

            GrLibrary[] libraries = [grLoadStdLibrary(), loadLibrary()];

            GrCompiler compiler = new GrCompiler;
            foreach (library; libraries) {
                compiler.addLibrary(library);
            }

            compiler.addFile(sourceFile);

            int options = GrOption.none;

            if (cli.hasOption("profile")) {
                options |= GrOption.profile;
            }
            if (cli.hasOption("safe")) {
                options |= GrOption.safe;
            }
            if (cli.hasOption("symbols")) {
                options |= GrOption.symbols;
            }
            writeln("compilation de `", sourceFile, "`");

            try {
                long startTime = Clock.currStdTime();
                GrBytecode bytecode = compiler.compile(options, GrLocale.fr_FR);
                enforce(bytecode, compiler.getError().prettify(GrLocale.fr_FR));
                double loadDuration = (cast(double)(Clock.currStdTime() - startTime) / 10_000_000.0);
                writeln("compilation effectuée en ", to!string(loadDuration), "sec");
                bytecode.save(bytecodePath);
                writeln("génération du bytecode `", sourceFile, "`");
            }
            catch (Exception e) {
                writeln(e.msg);
                writeln("compilation échouée");
            }

            return;
        }
    }

    enforce(false, "aucune configuration `" ~ configName ~ "` défini dans `" ~
            Atelier_Project_File ~ "`");
}
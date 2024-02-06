/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module atelier.doc;

import std.stdio : writeln, write;
import std.string;
import std.datetime;
import std.conv : to;
import std.path;
import std.file;
import grimoire;

import atelier.script;

void generateDoc() {
    const GrLocale locale = GrLocale.fr_FR;
    auto startTime = MonoTime.currTime();

    generate(locale);

    auto elapsedTime = MonoTime.currTime() - startTime;
    writeln("Documentation générée en ", elapsedTime);
}

alias LibLoader = void function(GrLibDefinition);
void generate(GrLocale locale) {
    LibLoader[] libLoaders = getLibraryLoaders();

    string[] modules;

    int i;
    foreach (libLoader; libLoaders) {
        GrDoc doc = new GrDoc("docgen" ~ to!string(i));
        libLoader(doc);

        const string generatedText = doc.generate(locale);

        string fileName = doc.getModule();
        modules ~= fileName;
        fileName ~= ".md";
        string folderName = to!string(locale);
        auto parts = folderName.split("_");
        if (parts.length >= 1)
            folderName = parts[0];
        std.file.write(buildNormalizedPath("docs", "lib", fileName), generatedText);
        i++;
    }

    { // Barre latérale
        string generatedText = "* [Accueil](/)\n";
        generatedText ~= "* [Bibliothèque](/lib/)\n";
        foreach (fileName; modules) {
            string line;

            line = "\t- [" ~ fileName ~ "](" ~ "lib/" ~ fileName ~ ")\n";

            generatedText ~= line;
        }
        std.file.write(buildNormalizedPath("docs", "_sidebar.md"), generatedText);
    }
}
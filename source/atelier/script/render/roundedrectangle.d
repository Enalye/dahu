/** 
 * Droits d’auteur: Enalye
 * Licence: Zlib
 * Auteur: Enalye
 */
module atelier.script.render.roundedrectangle;

import grimoire;

import atelier.common;
import atelier.render;
import atelier.script.util;

package void loadLibRender_roundedRectangle(GrLibDefinition library) {
    library.setModule("render.roundedrectangle");
    library.setModuleInfo(GrLocale.fr_FR, "Rectangle avec bords arrondis");
    library.setModuleExample(GrLocale.fr_FR, "var rect = @RoundedRectangle.fill(200f, 50f, 5f);
rect.anchor = @Vec2f.zero;
rect.position = @Vec2f.zero;
rect.color = @Color.red;
entity.addImage(rect);");

    GrType rrectType = library.addNative("RoundedRectangle", [], "Image");

    GrType vec2fType = grGetNativeType("Vec2", [grFloat]);

    library.setDescription(GrLocale.fr_FR, "Construit un rectangle arrondi plein");
    library.setParameters(["x", "y", "radius"]);
    library.addStatic(&_fill, rrectType, "fill", [grFloat, grFloat, grFloat], [
            rrectType
        ]);

    library.setDescription(GrLocale.fr_FR, "Construit le contour d’un rectangle arrondi");
    library.setParameters(["x", "y", "radius", "thickness"]);
    library.addStatic(&_outline, rrectType, "outline", [
            grFloat, grFloat, grFloat, grFloat
        ], [rrectType]);

    library.setDescription(GrLocale.fr_FR, "Taille du rectangle");
    library.addProperty(&_size!"get", &_size!"set", "size", rrectType, vec2fType);

    library.setDescription(GrLocale.fr_FR, "Rayon des coins du rectangle");
    library.addProperty(&_radius!"get", &_radius!"set", "radius", rrectType, grFloat);

    library.setDescription(GrLocale.fr_FR,
        "Si `true`, le rectangle est plein, sinon le rectangle est une bordure");
    library.addProperty(&_filled!"get", &_filled!"set", "filled", rrectType, grBool);

    library.setDescription(GrLocale.fr_FR,
        "(Seulement si `filled` == false) Épaisseur de la bordure");
    library.addProperty(&_thickness!"get", &_thickness!"set", "thickness", rrectType, grFloat);
}

private void _fill(GrCall call) {
    call.setNative(RoundedRectangle.fill(Vec2f(call.getFloat(0),
            call.getFloat(1)), call.getFloat(2)));
}

private void _outline(GrCall call) {
    call.setNative(RoundedRectangle.outline(Vec2f(call.getFloat(0),
            call.getFloat(1)), call.getFloat(2), call.getFloat(3)));
}

private void _size(string op)(GrCall call) {
    RoundedRectangle rect = call.getNative!RoundedRectangle(0);

    static if (op == "set") {
        rect.size = call.getNative!SVec2f(1);
    }
    call.setNative(svec2(rect.size));
}

private void _radius(string op)(GrCall call) {
    RoundedRectangle rect = call.getNative!RoundedRectangle(0);

    static if (op == "set") {
        rect.radius = call.getFloat(1);
    }
    call.setFloat(rect.radius);
}

private void _filled(string op)(GrCall call) {
    RoundedRectangle rect = call.getNative!RoundedRectangle(0);

    static if (op == "set") {
        rect.filled = call.getBool(1);
    }

    call.setBool(rect.filled);
}

private void _thickness(string op)(GrCall call) {
    RoundedRectangle rect = call.getNative!RoundedRectangle(0);

    static if (op == "set") {
        rect.thickness = call.getFloat(1);
    }
    call.setFloat(rect.thickness);
}

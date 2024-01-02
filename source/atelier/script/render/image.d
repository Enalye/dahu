/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module atelier.script.render.image;

import grimoire;

import atelier.common;
import atelier.render;

import atelier.script.util;

package void loadLibRender_image(GrLibDefinition lib) {
    GrType imageType = lib.addNative("Image");
    GrType colorType = grGetNativeType("Color");
    GrType vec2fType = grGetNativeType("Vec2", [grFloat]);
    GrType vec4iType = grGetNativeType("Vec4", [grInt]);

    lib.addProperty(&_anchor!"get", &_anchor!"set", "anchor", imageType, vec2fType);
    lib.addProperty(&_pivot!"get", &_pivot!"set", "pivot", imageType, vec2fType);
    lib.addProperty(&_angle!"get", &_angle!"set", "angle", imageType, grDouble);
    lib.addProperty(&_color!"get", &_color!"set", "color", imageType, colorType);
    lib.addProperty(&_alpha!"get", &_alpha!"set", "alpha", imageType, grFloat);

    lib.addFunction(&_fit, "fit", [imageType, grFloat, grFloat]);
    lib.addFunction(&_contain, "contain", [imageType, grFloat, grFloat]);
}

private void _anchor(string op)(GrCall call) {
    Image image = call.getNative!Image(0);

    static if (op == "set") {
        image.anchor = call.getNative!SVec2f(1);
    }
    call.setNative(svec2(image.anchor));
}

private void _pivot(string op)(GrCall call) {
    Image image = call.getNative!Image(0);

    static if (op == "set") {
        image.pivot = call.getNative!SVec2f(1);
    }
    call.setNative(svec2(image.pivot));
}

private void _angle(string op)(GrCall call) {
    Image image = call.getNative!Image(0);

    static if (op == "set") {
        image.angle = call.getDouble(1);
    }
    call.setDouble(image.angle);
}

private void _color(string op)(GrCall call) {
    Image image = call.getNative!Image(0);

    static if (op == "set") {
        image.color = call.getNative!SColor(1);
    }
    call.setNative(scolor(image.color));
}

private void _alpha(string op)(GrCall call) {
    Image image = call.getNative!Image(0);

    static if (op == "set") {
        image.alpha = call.getFloat(1);
    }
    call.setFloat(image.alpha);
}

private void _fit(GrCall call) {
    Image image = call.getNative!Image(0);

    image.fit(Vec2f(call.getFloat(1), call.getFloat(2)));
}

private void _contain(GrCall call) {
    Image image = call.getNative!Image(0);

    image.contain(Vec2f(call.getFloat(1), call.getFloat(2)));
}
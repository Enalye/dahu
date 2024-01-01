/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module dahu.script.render.capsule;

import grimoire;

import dahu.common;
import dahu.render;
import dahu.script.util;

package void loadLibRender_capsule(GrLibDefinition lib) {
    GrType capsuleType = lib.addNative("Capsule", [], "Image");

    GrType vec2fType = grGetNativeType("Vec2", [grFloat]);

    lib.addConstructor(&_ctor, capsuleType, [grFloat, grFloat, grBool, grFloat]);

    lib.addProperty(&_size!"get", &_size!"set", "size", capsuleType, vec2fType);
    lib.addProperty(&_filled!"get", &_filled!"set", "filled", capsuleType, grBool);
    lib.addProperty(&_thickness!"get", &_thickness!"set", "thickness", capsuleType, grFloat);
}

private void _ctor(GrCall call) {
    call.setNative(new Capsule(Vec2f(call.getFloat(0), call.getFloat(1)),
            call.getBool(2), call.getFloat(3)));
}

private void _size(string op)(GrCall call) {
    Capsule capsule = call.getNative!Capsule(0);

    static if (op == "set") {
        capsule.size = call.getNative!SVec2f(1);
    }
    call.setNative(svec2(capsule.size));
}

private void _filled(string op)(GrCall call) {
    Capsule capsule = call.getNative!Capsule(0);

    static if (op == "set") {
        capsule.filled = call.getBool(1);
    }

    call.setBool(capsule.filled);
}

private void _thickness(string op)(GrCall call) {
    Capsule capsule = call.getNative!Capsule(0);

    static if (op == "set") {
        capsule.thickness = call.getFloat(1);
    }
    call.setFloat(capsule.thickness);
}

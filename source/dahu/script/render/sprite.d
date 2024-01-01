/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module dahu.script.render.sprite;

import grimoire;

import dahu.common;
import dahu.core;
import dahu.input;
import dahu.render;
import dahu.script.util;

void loadLibRender_sprite(GrLibDefinition lib) {
    GrType spriteType = lib.addNative("Sprite", [], "Image");

    GrType vec2fType = grGetNativeType("Vec2", [grFloat]);

    lib.addConstructor(&_sprite, spriteType, [grString]);

    lib.addProperty(&_size!"get", &_size!"set", "size", spriteType, vec2fType);
}

private void _sprite(GrCall call) {
    call.setNative(Dahu.res.get!Sprite(call.getString(0)));
}

private void _size(string op)(GrCall call) {
    Sprite sprite = call.getNative!Sprite(0);

    static if (op == "set") {
        sprite.size = call.getNative!SVec2f(1);
    }
    call.setNative(svec2(sprite.size));
}

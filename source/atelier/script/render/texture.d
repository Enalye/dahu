/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module atelier.script.render.texture;

import grimoire;

import atelier.common;
import atelier.core;
import atelier.input;
import atelier.render;

void loadLibRender_texture(GrLibDefinition library) {
    GrType textureType = library.addNative("Texture", [], "ImageData");
    
}
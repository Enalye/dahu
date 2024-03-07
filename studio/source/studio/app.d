/** 
 * Droits d’auteur: Enalye
 * Licence: Zlib
 * Auteur: Enalye
 */
import etabli;

import studio.ui;

/// Logo 64×64
private immutable ubyte[] _logo64Data = [
    0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x40,
    0x08, 0x06, 0x00, 0x00, 0x00, 0xaa, 0x69, 0x71, 0xde, 0x00, 0x00, 0x00,
    0x09, 0x70, 0x48, 0x59, 0x73, 0x00, 0x00, 0x1d, 0x87, 0x00, 0x00, 0x1d,
    0x87, 0x01, 0x8f, 0xe5, 0xf1, 0x65, 0x00, 0x00, 0x00, 0x19, 0x74, 0x45,
    0x58, 0x74, 0x53, 0x6f, 0x66, 0x74, 0x77, 0x61, 0x72, 0x65, 0x00, 0x77,
    0x77, 0x77, 0x2e, 0x69, 0x6e, 0x6b, 0x73, 0x63, 0x61, 0x70, 0x65, 0x2e,
    0x6f, 0x72, 0x67, 0x9b, 0xee, 0x3c, 0x1a, 0x00, 0x00, 0x04, 0x74, 0x49,
    0x44, 0x41, 0x54, 0x78, 0x9c, 0xed, 0x9b, 0x5f, 0x4c, 0x5b, 0x55, 0x1c,
    0xc7, 0x3f, 0xe7, 0x96, 0x42, 0x19, 0x0d, 0x0c, 0xc6, 0xdf, 0xa9, 0xdb,
    0x60, 0x43, 0xb3, 0x45, 0x33, 0x7d, 0x30, 0x9a, 0x60, 0xd9, 0x16, 0xf7,
    0x60, 0x74, 0x0f, 0xbe, 0x68, 0xcc, 0x62, 0xcc, 0xdc, 0xbf, 0xb8, 0x27,
    0x81, 0x25, 0x4b, 0x60, 0xc4, 0x61, 0x02, 0x31, 0x61, 0x91, 0xa9, 0x0f,
    0x26, 0xb2, 0x61, 0xe2, 0xa2, 0x33, 0xc6, 0x64, 0x31, 0x11, 0x8d, 0x89,
    0x0f, 0xcb, 0x60, 0x8b, 0xee, 0xcd, 0x90, 0x4d, 0xa2, 0x9b, 0x1b, 0xc3,
    0xa1, 0x0c, 0x02, 0x6c, 0xa1, 0x40, 0x69, 0x6f, 0x7b, 0x7c, 0x60, 0x45,
    0xda, 0x1e, 0x46, 0x4b, 0xdb, 0x7b, 0xee, 0x56, 0x3e, 0x8f, 0xe7, 0x9c,
    0x7b, 0x7e, 0xdf, 0xfb, 0xed, 0xf9, 0x9d, 0xfb, 0x3b, 0xb9, 0xbd, 0x42,
    0x4a, 0xc9, 0x42, 0x6a, 0xeb, 0x8f, 0x56, 0x00, 0xfb, 0x81, 0x5d, 0x40,
    0x25, 0x50, 0xc2, 0x83, 0xcd, 0x28, 0x70, 0x43, 0x48, 0xf9, 0xbd, 0x91,
    0x6d, 0x9e, 0x3a, 0xd7, 0xde, 0x3e, 0xbc, 0xb0, 0x53, 0x84, 0x0d, 0x10,
    0x42, 0x88, 0xda, 0xba, 0xc6, 0xc3, 0x12, 0xd1, 0x02, 0xe4, 0x59, 0xaf,
    0xd3, 0x12, 0xa6, 0x24, 0xe2, 0xbd, 0xde, 0x13, 0xad, 0x1d, 0xe1, 0x06,
    0x21, 0xa5, 0x44, 0x08, 0x21, 0x3c, 0x75, 0x4d, 0x9d, 0xcc, 0xfd, 0xf2,
    0x0f, 0x3f, 0x42, 0x9c, 0xec, 0xe9, 0x68, 0x3d, 0x08, 0x60, 0x00, 0xd4,
    0xd6, 0x35, 0x1e, 0x26, 0x53, 0x6e, 0x1e, 0x40, 0xca, 0x03, 0x9e, 0xfa,
    0xe6, 0x06, 0x00, 0xe1, 0xa9, 0x6b, 0xaa, 0x00, 0xae, 0xf2, 0xf0, 0x2e,
    0xfb, 0xc5, 0xf0, 0x3a, 0x9c, 0x81, 0x6a, 0x83, 0xb9, 0x5f, 0x3e, 0xd3,
    0x6e, 0x1e, 0xc0, 0x1d, 0xf2, 0x67, 0xed, 0x37, 0x80, 0x57, 0x74, 0x2b,
    0xd1, 0x85, 0x14, 0xe2, 0x65, 0x03, 0xa8, 0xd6, 0x2d, 0x44, 0x23, 0x9b,
    0x0c, 0xa0, 0x50, 0xb7, 0x0a, 0x8d, 0x14, 0x1b, 0x80, 0xd0, 0xad, 0x42,
    0x23, 0xc2, 0xd0, 0xad, 0x40, 0x37, 0x2b, 0x06, 0xe8, 0x16, 0xa0, 0x9b,
    0x15, 0x03, 0x74, 0x0b, 0xd0, 0x4d, 0x96, 0x6e, 0x01, 0x61, 0x36, 0xaf,
    0x7f, 0x8c, 0x57, 0x6b, 0x9e, 0x8f, 0x68, 0xeb, 0xbf, 0x39, 0xc8, 0x77,
    0x17, 0x2f, 0xa5, 0x35, 0xae, 0xd2, 0x80, 0x42, 0xb7, 0x9b, 0x0f, 0x0f,
    0xed, 0x4d, 0x59, 0x90, 0x50, 0x48, 0xf2, 0xc7, 0xad, 0x21, 0x4e, 0x76,
    0xff, 0xc4, 0x9d, 0xa9, 0x69, 0xe5, 0x98, 0xe2, 0xfc, 0x7c, 0x3c, 0x4f,
    0x6d, 0x89, 0x6a, 0x95, 0x7a, 0x0c, 0x70, 0x38, 0x0c, 0xca, 0x8b, 0x52,
    0x5b, 0x1f, 0xad, 0x2d, 0x2e, 0x62, 0xb5, 0xdb, 0xcd, 0xd1, 0xae, 0xd3,
    0x8b, 0x8c, 0x90, 0x8a, 0xb6, 0xf4, 0x97, 0x28, 0x96, 0xee, 0x01, 0x4f,
    0x6f, 0xdc, 0x80, 0x33, 0xcb, 0x36, 0x59, 0x07, 0x58, 0x6c, 0x80, 0x10,
    0x02, 0x87, 0x43, 0x1d, 0x52, 0x2a, 0x16, 0x80, 0xb0, 0xa0, 0x46, 0xb5,
    0xcd, 0x53, 0x40, 0x2a, 0x52, 0x40, 0x58, 0x90, 0x02, 0xca, 0xf5, 0x38,
    0x31, 0xe9, 0x65, 0xef, 0xf1, 0x4f, 0x92, 0x9e, 0xfc, 0xd3, 0x77, 0x0f,
    0xe1, 0xca, 0x76, 0x26, 0x3d, 0x4f, 0x3a, 0x51, 0x1a, 0x10, 0x0c, 0x85,
    0x18, 0x1e, 0x9f, 0x48, 0x7e, 0x76, 0xd5, 0xba, 0x4e, 0x60, 0x68, 0x46,
    0xa5, 0x80, 0x2e, 0x07, 0x6c, 0x63, 0x80, 0x9e, 0x87, 0xa0, 0x8d, 0x0c,
    0xd0, 0x85, 0x6d, 0x0c, 0xb0, 0xd5, 0x53, 0x20, 0xcc, 0xba, 0xb2, 0x12,
    0xd6, 0x95, 0x94, 0x2c, 0x99, 0x8a, 0x5e, 0x9f, 0x4f, 0x99, 0xc3, 0xc2,
    0x88, 0xbd, 0x70, 0x6b, 0xd5, 0x06, 0xfc, 0x81, 0x40, 0x4c, 0x7b, 0x65,
    0x45, 0x59, 0x4c, 0x9b, 0x3b, 0xd7, 0x45, 0xf5, 0x23, 0x6b, 0xef, 0x1f,
    0xfc, 0x1e, 0x81, 0xa0, 0xc9, 0xc0, 0xf0, 0x48, 0x5c, 0x63, 0x23, 0x34,
    0x7a, 0xea, 0x9a, 0x94, 0x5b, 0xf5, 0x9b, 0x3b, 0xb7, 0xb3, 0xfb, 0xc5,
    0x6d, 0x09, 0x4f, 0xa8, 0x8b, 0x91, 0x89, 0x3b, 0xec, 0x69, 0xff, 0x38,
    0xe1, 0xeb, 0x94, 0x29, 0xb0, 0xda, 0x9d, 0xc7, 0x1b, 0x3b, 0x3c, 0x49,
    0x8b, 0xb2, 0x92, 0x04, 0x9e, 0xb8, 0x11, 0x28, 0x0d, 0x28, 0x2d, 0x28,
    0xc0, 0x30, 0x6c, 0xb3, 0x3d, 0xc4, 0x85, 0x6a, 0x0f, 0x89, 0x07, 0xf5,
    0x5d, 0x5a, 0x51, 0x81, 0xa4, 0x98, 0xe5, 0xae, 0x80, 0xb8, 0x8f, 0x66,
    0x93, 0x33, 0x33, 0xfc, 0x76, 0xed, 0x86, 0xb2, 0xcf, 0x9d, 0x9b, 0xab,
    0x6c, 0xdf, 0x5a, 0xb5, 0x3e, 0x66, 0x25, 0xf5, 0x5d, 0x1f, 0x20, 0x18,
    0x8a, 0x55, 0x9b, 0x9f, 0x97, 0xcb, 0xc6, 0x8a, 0xf2, 0x88, 0xb6, 0x69,
    0xdf, 0x2c, 0x43, 0x63, 0x63, 0x71, 0xe9, 0x1b, 0xbb, 0x3b, 0x19, 0xd7,
    0xb8, 0x68, 0xe2, 0x36, 0xe0, 0xdf, 0xb1, 0x71, 0x3e, 0x38, 0xf3, 0x6d,
    0x42, 0x93, 0x9f, 0x6d, 0x69, 0xc4, 0x95, 0x93, 0x1d, 0xd1, 0xd6, 0x72,
    0xfa, 0x6b, 0x7c, 0xb3, 0xfe, 0x98, 0xb1, 0xcf, 0x3e, 0x51, 0xcd, 0xfb,
    0x7b, 0x76, 0x47, 0xb4, 0x5d, 0x19, 0x18, 0xe4, 0xd8, 0x17, 0x67, 0x12,
    0x8a, 0x99, 0x28, 0x36, 0x4a, 0xf4, 0x0c, 0x2f, 0x85, 0x75, 0x61, 0x1b,
    0x03, 0x32, 0xfe, 0x34, 0xa8, 0xab, 0x14, 0xb6, 0x8f, 0x01, 0x99, 0xbe,
    0x02, 0x74, 0x61, 0x1b, 0x03, 0x32, 0x3e, 0x05, 0x74, 0xe5, 0x40, 0xdc,
    0x85, 0xd0, 0xaa, 0x1c, 0x17, 0xcf, 0x6c, 0xaa, 0x4c, 0x68, 0x72, 0xd5,
    0x71, 0xd8, 0x6e, 0xc4, 0x6d, 0xc0, 0xa3, 0x25, 0x6b, 0x68, 0xdb, 0xf7,
    0x56, 0xda, 0x84, 0xa8, 0x4a, 0xf9, 0xf2, 0xc2, 0x02, 0x5e, 0xdb, 0x56,
    0xb3, 0xf8, 0x35, 0x12, 0xa6, 0x7c, 0xbe, 0x25, 0xe7, 0xf6, 0x07, 0x4c,
    0xfc, 0x66, 0x60, 0xfe, 0x9a, 0x0b, 0x97, 0x7f, 0x9f, 0xef, 0xb3, 0xcd,
    0x6b, 0x9a, 0xe8, 0xff, 0x2c, 0x03, 0x54, 0xac, 0x29, 0xe2, 0xed, 0x97,
    0x76, 0xa6, 0x34, 0x8e, 0x19, 0x0c, 0x72, 0xa1, 0xf9, 0x7f, 0x03, 0x94,
    0x7b, 0xc0, 0x8c, 0x7f, 0x36, 0xa5, 0x41, 0xc3, 0x04, 0x43, 0x21, 0x4c,
    0x33, 0xa8, 0xec, 0x5b, 0xee, 0x69, 0x2e, 0x51, 0xa2, 0xc3, 0x28, 0x0d,
    0xb8, 0x35, 0x3a, 0xc6, 0xd5, 0xa1, 0x7f, 0x52, 0x1e, 0xbc, 0xa7, 0xef,
    0x0a, 0x66, 0x50, 0x6d, 0xc0, 0xdd, 0xa9, 0xa9, 0x94, 0xc7, 0x53, 0x11,
    0xbd, 0xd2, 0x94, 0x29, 0x20, 0xa5, 0xa4, 0xf9, 0xf3, 0xaf, 0x78, 0x7d,
    0x7b, 0x0d, 0xeb, 0xcb, 0x4a, 0x71, 0x18, 0x8e, 0xa4, 0x82, 0x9a, 0xa6,
    0x49, 0xff, 0xe0, 0xdf, 0x9c, 0xed, 0xfd, 0x65, 0xd1, 0x31, 0x37, 0x6f,
    0x8f, 0x72, 0xa9, 0xff, 0x4f, 0x9e, 0xdb, 0xfc, 0x78, 0x52, 0xb1, 0x96,
    0x22, 0x2e, 0x03, 0x00, 0x26, 0xa7, 0xa7, 0xe9, 0xfa, 0xf1, 0xe7, 0xb4,
    0x8a, 0x89, 0xa6, 0xf5, 0xcb, 0x6f, 0x78, 0xe1, 0xc9, 0x2d, 0x94, 0x16,
    0x16, 0xe0, 0xca, 0xce, 0x26, 0xcb, 0x71, 0x7f, 0xe3, 0x0d, 0x21, 0x58,
    0xe5, 0xca, 0x59, 0x72, 0xde, 0x1c, 0xa7, 0x73, 0xfe, 0xad, 0x74, 0xc0,
    0x34, 0x23, 0xfa, 0x6c, 0xb3, 0x09, 0xc2, 0xdc, 0x1e, 0x71, 0xbe, 0xef,
    0xb2, 0xa5, 0x31, 0xed, 0x53, 0x08, 0x69, 0x62, 0xc5, 0x00, 0xdd, 0x02,
    0x74, 0xb3, 0x62, 0x80, 0x6e, 0x01, 0xba, 0x31, 0x50, 0x97, 0xe1, 0x99,
    0x82, 0x34, 0x80, 0x71, 0xdd, 0x2a, 0xf4, 0x21, 0x47, 0x0d, 0xe0, 0x9a,
    0x6e, 0x19, 0xfa, 0x10, 0x7f, 0x19, 0x42, 0xca, 0x6e, 0xdd, 0x32, 0x74,
    0x21, 0xe1, 0x07, 0xc3, 0x74, 0xe6, 0x74, 0x02, 0xcb, 0x7b, 0xaf, 0xf4,
    0x60, 0xe3, 0xcd, 0x72, 0x06, 0xba, 0x8c, 0x8b, 0xc7, 0x8f, 0x8d, 0xdc,
    0xfb, 0x5c, 0x36, 0xa3, 0x10, 0x82, 0xe6, 0x73, 0xed, 0xed, 0xc3, 0xf3,
    0xdf, 0x0e, 0xd7, 0x36, 0x34, 0x77, 0x22, 0xe5, 0x01, 0xcd, 0xba, 0x2c,
    0x41, 0xc2, 0x67, 0xbd, 0x27, 0xda, 0xde, 0x81, 0x05, 0x75, 0x40, 0x4f,
    0x47, 0xeb, 0x41, 0x04, 0x0d, 0x80, 0x57, 0x9b, 0xb2, 0xf4, 0xe3, 0x05,
    0x51, 0x1f, 0xbe, 0x79, 0x58, 0xf0, 0xf5, 0x78, 0x98, 0x1d, 0x47, 0x8e,
    0x94, 0x9b, 0x01, 0xe7, 0x3e, 0x43, 0xb2, 0x4b, 0x0a, 0x59, 0x05, 0xa2,
    0xd4, 0x72, 0x99, 0x29, 0x45, 0x8e, 0x08, 0x29, 0xae, 0x87, 0x04, 0xdd,
    0x01, 0xc9, 0xa9, 0x5f, 0x3f, 0x6a, 0xbb, 0xbd, 0xb0, 0xf7, 0x3f, 0x39,
    0x4d, 0x50, 0xd2, 0x86, 0x12, 0x74, 0x5f, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4e, 0x44, 0xae, 0x42, 0x60, 0x82,
];

void main() {
    Etabli etabli = new Etabli(800, 600, "Studio Atelier");

    etabli.renderer.color = Color.fromHex(0x101010);

    etabli.ui.addUI(new Editor);

    etabli.window.setIconFromMemory(_logo64Data);
    etabli.run();
}

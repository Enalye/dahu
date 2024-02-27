/** 
 * Droits d’auteur: Enalye
 * Licence: Zlib
 * Auteur: Enalye
 */
module atelier.render.tilemap;

import std.conv : to;
import std.exception : enforce;
import std.math : floor, ceil;
import std.algorithm.comparison : min, max;

import atelier.common;
import atelier.core;
import atelier.scene;
import atelier.render.image;
import atelier.render.tileset;

final class Tilemap : Image, Resource!Tilemap {
    private {
        Tileset _tileset;
        uint _currentTick;
        short[] _tiles;
        int _width, _height;
    }

    Vec2f size = Vec2f.zero;

    this(Tileset tileset, int width, int height) {
        _tileset = tileset;
        _width = width;
        _height = height;
        clip = _tileset.clip;
        size = cast(Vec2f) clip.zw;

        _tiles.length = _width * _height;
        foreach (ref short tile; _tiles) {
            tile = 5;
        }
    }

    this(Tilemap tilemap) {
        super(tilemap);
        _tileset = tilemap._tileset;
        _width = tilemap._width;
        _height = tilemap._height;
        _tiles = tilemap._tiles;
        size = tilemap.size;
    }

    /// Accès à la ressource
    Tilemap fetch() {
        return new Tilemap(this);
    }

    int getTile(int x, int y) {
        if (x < 0 || y < 0 || x >= _width || y >= _height)
            return 0;

        return _tiles[x + y * _width];
    }

    void setTile(int x, int y, int tile) {
        if (x < 0 || y < 0 || x >= _width || y >= _height)
            return;

        _tiles[x + y * _width] = cast(short) tile;
    }

    void setTiles(const(int[][]) tiles_) {
        enforce(tiles_.length == _height, "taille des tuiles invalides: " ~ to!string(
                tiles_.length) ~ " lignes au lieu de " ~ to!string(_height));
        foreach (size_t y, ref const(int[]) line; tiles_) {
            enforce(line.length == _width, "taille des tuiles invalides: " ~ to!string(
                    tiles_.length) ~ " colonnes au lieu de " ~ to!string(
                    _width) ~ " à la ligne " ~ to!string(y));
            foreach (size_t x, int tileId; line) {
                _tiles[x + y * _width] = cast(short) tileId;
            }
        }
    }

    /// Redimensionne l’image pour qu’elle puisse tenir dans une taille donnée
    override void fit(Vec2f size_) {
        size = to!Vec2f(clip.zw).fit(size_);
    }

    /// Redimensionne l’image pour qu’elle puisse contenir une taille donnée
    override void contain(Vec2f size_) {
        size = to!Vec2f(clip.zw).contain(size_);
    }

    override void update() {
        _currentTick++;
        if (_currentTick >= _tileset.frameTime) {
            _currentTick = 0;
            foreach (ref tile; _tiles) {
                tile = _tileset.getTileFrame(tile);
            }
        }
    }

    override void draw(Vec2f origin = Vec2f.zero) {
        _tileset.color = color;
        _tileset.alpha = alpha;
        _tileset.blend = blend;

        Vec2f startPos = origin + position - (size * anchor);

        int minX = 0;
        int minY = 0;
        int maxX = _width;
        int maxY = _height;

        if (Atelier.scene.isOnScene) {
            Vec4f cameraClip = Atelier.scene.cameraClip;
            minX = max(0, cast(int) floor((cameraClip.x - startPos.x) / size.x));
            minY = max(0, cast(int) floor((cameraClip.y - startPos.y) / size.y));
            maxX = min(_width, cast(int) ceil((cameraClip.z - startPos.x) / size.x));
            maxY = min(_height, cast(int) ceil((cameraClip.w - startPos.y) / size.y));
        }

        Vec2f tilePos;
        int renderedTiles;
        for (int y = minY; y < maxY; y++) {
            for (int x = minX; x < maxX; x++) {
                tilePos = startPos;
                tilePos.x += x * size.x;
                tilePos.y += y * size.y;

                int tileId = _tiles[x * _width + y];
                renderedTiles++;

                if (tileId >= 0)
                    _tileset.draw(tileId, tilePos, size, angle);
            }
        }
    }
}

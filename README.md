# WGSL Noise

This a `.wgsl` implementation of common noise algorithms.

## Files

### Common File
- `common.wgsl`: contain common functions used by other files.

### Perlin Noise
- `perlin_vec2f.wgsl`: Perlin noise algorithm for 2 dimensional input.
- `perlin_vec3f.wgsl`: Perlin noise algorithm for 3 dimensional input.
- `perlin_vec4f.wgsl`: Perlin noise algorithm for 4 dimensional input.

### Simplex Noise
- `simplex_vec2f.wgsl`: Simplex noise algorithm for 2 dimensional input.
- `simplex_vec3f.wgsl`: Simplex noise algorithm for 3 dimensional input.
- `simplex_vec4f.wgsl`: Simplex noise algorithm for 4 dimensional input.

## License

This project is under MIT License.

## Reference

- [glsl implementation](https://github.com/ashima/webgl-noise)

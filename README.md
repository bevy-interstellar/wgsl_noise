# WGSL Noise

This a `.wgsl` implementation of common noise algorithms.

## Files

### Common File
- `common.wgsl`: contain common functions used by other files.

### Random Noise
- `random_all.wgsl`: Perlin noise algorithm for 2, 3, 4 dimensional input.

### Perlin Noise
- `perlin_vec2f.wgsl`: Perlin noise algorithm for 2 dimensional input.
- `perlin_vec3f.wgsl`: Perlin noise algorithm for 3 dimensional input.
- `perlin_vec4f.wgsl`: Perlin noise algorithm for 4 dimensional input.

### Simplex Noise
- `simplex_vec2f.wgsl`: Simplex noise algorithm for 2 dimensional input.
- `simplex_vec3f.wgsl`: Simplex noise algorithm for 3 dimensional input.
- `simplex_vec4f.wgsl`: Simplex noise algorithm for 4 dimensional input.

### Worley Noise

- `worley_vec2f.wgsl`: Worley noise algorithm for 2 dimensional input; `WORLEY_IGNORE_F2` flag can control if compute F2 value or not.
- `worley_vec3f.wgsl`: Worley noise algorithm for 3 dimensional input; `WORLEY_IGNORE_F2` flag can control if compute F2 value or not.

### Voronoi Noise

TODO

### Fractal Brownian Motion

- `fbm_all.wgsl`: fractal brownian motion algorithms on either Perlin or Simplex noise, for 2, 3, 4 dimensional input.

### Domain Distortion

- `distortion_all.wgsl`: domain distortion algorithm on fbm algorithm.

## License

This project is under MIT License.

## Reference

- [glsl implementation](https://github.com/ashima/webgl-noise)

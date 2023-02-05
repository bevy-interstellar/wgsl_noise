/// This file is code generated, please do not 
/// edit it manually. If you want to modify, 
/// change the corresponding template file.

#define_import_path noise::distortion_all

#ifdef UNDEFINED
#import noise::fbm_all
#endif

fn noise_distortion_perlin_vec2f(v: vec2<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_perlin_vec2f(v + res, octa, lacu, gain);
    }

    return res;
}

fn noise_distortion_perlin_vec3f(v: vec3<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_perlin_vec3f(v + res, octa, lacu, gain);
    }

    return res;
}

fn noise_distortion_perlin_vec4f(v: vec4<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_perlin_vec4f(v + res, octa, lacu, gain);
    }

    return res;
}

fn noise_distortion_simplex_vec2f(v: vec2<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_simplex_vec2f(v + res, octa, lacu, gain);
    }

    return res;
}

fn noise_distortion_simplex_vec3f(v: vec3<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_simplex_vec3f(v + res, octa, lacu, gain);
    }

    return res;
}

fn noise_distortion_simplex_vec4f(v: vec4<f32>, iter: i32, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;

    for (var i = 0; i < iter; i++) {
        res = noise_fbm_simplex_vec4f(v + res, octa, lacu, gain);
    }

    return res;
}

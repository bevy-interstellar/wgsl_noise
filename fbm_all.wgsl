/// This file is code generated, please do not 
/// edit it manually. If you want to modify, 
/// change the corresponding template file.

#define_import_path noise::fbm_all

#ifdef UNDEFINED
#import noise::common
#import noise::perlin_vec2f
#import noise::perlin_vec3f
#import noise::perlin_vec4f
#import noise::simplex_vec2f
#import noise::simplex_vec3f
#import noise::simplex_vec4f
#endif

fn noise_fbm_perlin_vec2f(v: vec2<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_perlin_vec2f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

fn noise_fbm_perlin_vec3f(v: vec3<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_perlin_vec3f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

fn noise_fbm_perlin_vec4f(v: vec4<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_perlin_vec4f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

fn noise_fbm_simplex_vec2f(v: vec2<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_simplex_vec2f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

fn noise_fbm_simplex_vec3f(v: vec3<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_simplex_vec3f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

fn noise_fbm_simplex_vec4f(v: vec4<f32>, octa: i32, lacu: f32, gain: f32) -> f32 {
    var res = 0.0;
    var ampl = 0.5;
    var freq = 1.0;
    for (var i = 0; i < octa; i++) {
        res += ampl * noise_simplex_vec4f(freq * v);
        freq *= lacu;
        ampl *= gain;
    }

    return res;
}

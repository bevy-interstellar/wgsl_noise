/// This file is code generated, please do not 
/// edit it manually. If you want to modify, 
/// change the corresponding template file.

#define_import_path noise::common

/// a file contains common functions shared by multiple noise algorithm

fn noise_rand(x: f32) -> f32 {
    return fract(sin(x) * 43759.473);
}

fn noise_permute_f32(x: f32) -> f32 {
    return (((x * 34.0) + 10.0) * x) % 289.0;
}

fn noise_fade_f32(x: f32) -> f32 {
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}

fn noise_permute_vec2f(x: vec2<f32>) -> vec2<f32> {
    return (((x * 34.0) + 10.0) * x) % 289.0;
}

fn noise_fade_vec2f(x: vec2<f32>) -> vec2<f32> {
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}

fn noise_permute_vec3f(x: vec3<f32>) -> vec3<f32> {
    return (((x * 34.0) + 10.0) * x) % 289.0;
}

fn noise_fade_vec3f(x: vec3<f32>) -> vec3<f32> {
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}

fn noise_permute_vec4f(x: vec4<f32>) -> vec4<f32> {
    return (((x * 34.0) + 10.0) * x) % 289.0;
}

fn noise_fade_vec4f(x: vec4<f32>) -> vec4<f32> {
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}

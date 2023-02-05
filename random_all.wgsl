#define_import_path noise::random_all

#ifdef UNDEFINED
#import noise::common
#endif

fn noise_random_vec2f(v: vec2<f32>) -> f32 {
    let rx = noise_rand(v.x);
    let ry = noise_rand(rx + v.y);
    return noise_rand(dot(v, vec2(rx, ry)));
}

fn noise_random_vec3f(v: vec3<f32>) -> f32 {
    let rx = noise_rand(v.x);
    let ry = noise_rand(rx + v.y);
    let rz = noise_rand(ry + v.z);
    return noise_rand(dot(v, vec3(rx, ry, rz)));
}

fn noise_random_vec4f(v: vec4<f32>) -> f32 {
    let rx = noise_rand(v.x);
    let ry = noise_rand(rx + v.y);
    let rz = noise_rand(ry + v.z);
    let rw = noise_rand(rz + v.w);
    return noise_rand(dot(v, vec4(rx, ry, rz, rw)));
}

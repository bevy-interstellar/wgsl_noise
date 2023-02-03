#define_import_path noise::perlin_vec3f

#import noise::common

fn noise_perlin_vec3f(p: vec3<f32>) -> f32 {
    var pi0 = floor(p);     // Integer part for indexing
    var pi1 = pi0 + 1.0;    // Integer part + 1
    pi0 = pi0 % 289.0;
    pi1 = pi1 % 289.0;
    let pf0 = fract(p);     // Fractional part for interpolation
    let pf1 = pf0 - 1.0;    // Fractional part - 1.0
    let ix = vec4<f32>(pi0.x, pi1.x, pi0.x, pi1.x);
    let iy = vec4<f32>(pi0.yy, pi1.yy);
    let iz0 = pi0.zzzz;
    let iz1 = pi1.zzzz;

    let ixy = noise_permute_vec4f(noise_permute_vec4f(ix) + iy);
    let ixy0 = noise_permute_vec4f(ixy + iz0);
    let ixy1 = noise_permute_vec4f(ixy + iz1);

    var gx0 = ixy0 * (1.0 / 7.0);
    var gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
    gx0 = fract(gx0);
    let gz0 = 0.5 - abs(gx0) - abs(gy0);
    let sz0 = step(gz0, vec4<f32>(0.0));
    gx0 -= sz0 * (step(vec4<f32>(0.0), gx0) - 0.5);
    gy0 -= sz0 * (step(vec4<f32>(0.0), gy0) - 0.5);

    var gx1 = ixy1 * (1.0 / 7.0);
    var gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
    gx1 = fract(gx1);
    let gz1 = 0.5 - abs(gx1) - abs(gy1);
    let sz1 = step(gz1, vec4<f32>(0.0));
    gx1 -= sz1 * (step(vec4<f32>(0.0), gx1) - 0.5);
    gy1 -= sz1 * (step(vec4<f32>(0.0), gy1) - 0.5);

    var g000 = vec3<f32>(gx0.x, gy0.x, gz0.x);
    var g100 = vec3<f32>(gx0.y, gy0.y, gz0.y);
    var g010 = vec3<f32>(gx0.z, gy0.z, gz0.z);
    var g110 = vec3<f32>(gx0.w, gy0.w, gz0.w);
    var g001 = vec3<f32>(gx1.x, gy1.x, gz1.x);
    var g101 = vec3<f32>(gx1.y, gy1.y, gz1.y);
    var g011 = vec3<f32>(gx1.z, gy1.z, gz1.z);
    var g111 = vec3<f32>(gx1.w, gy1.w, gz1.w);

    let norm0 = inverseSqrt(vec4<f32>(
        dot(g000, g000),
        dot(g010, g010),
        dot(g100, g100),
        dot(g110, g110)
    ));
    g000 *= norm0.x;
    g010 *= norm0.y;
    g100 *= norm0.z;
    g110 *= norm0.w;
    let norm1 = inverseSqrt(vec4<f32>(
        dot(g001, g001),
        dot(g011, g011),
        dot(g101, g101),
        dot(g111, g111)
    ));
    g001 *= norm1.x;
    g011 *= norm1.y;
    g101 *= norm1.z;
    g111 *= norm1.w;

    let n000 = dot(g000, pf0);
    let n100 = dot(g100, vec3<f32>(pf1.x, pf0.yz));
    let n010 = dot(g010, vec3<f32>(pf0.x, pf1.y, pf0.z));
    let n110 = dot(g110, vec3<f32>(pf1.xy, pf0.z));
    let n001 = dot(g001, vec3<f32>(pf0.xy, pf1.z));
    let n101 = dot(g101, vec3<f32>(pf1.x, pf0.y, pf1.z));
    let n011 = dot(g011, vec3<f32>(pf0.x, pf1.yz));
    let n111 = dot(g111, pf1);

    let fade_xyz = noise_fade_vec3f(pf0);
    let n_z = mix(
        vec4<f32>(n000, n100, n010, n110),
        vec4<f32>(n001, n101, n011, n111),
        fade_xyz.z
    );
    let n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
    let n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x);
    return 2.2 * n_xyz;
}

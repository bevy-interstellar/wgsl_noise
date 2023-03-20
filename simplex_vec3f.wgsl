#define_import_path noise::simplex_vec3f
#ifndef IMPORT_NOISE_SIMPLEX_VEC3F
#define IMPORT_NOISE_SIMPLEX_VEC3F

#import noise::common

fn noise_simplex_vec3f(v: vec3<f32>) -> f32 {
    let c = vec2(1.0 / 6.0, 1.0 / 3.0) ;
    let d = vec4(0.0, 0.5, 1.0, 2.0);

    // First corner
    var i = floor(v + dot(v, c.yyy));
    let x0 = v - i + dot(i, c.xxx) ;

    // Other corners
    let g = step(x0.yzx, x0.xyz);
    let l = 1.0 - g;
    let i1 = min(g.xyz, l.zxy);
    let i2 = max(g.xyz, l.zxy);

    //   x0 = x0 - 0.0 + 0.0 * C.xxx;
    //   x1 = x0 - i1  + 1.0 * C.xxx;
    //   x2 = x0 - i2  + 2.0 * C.xxx;
    //   x3 = x0 - 1.0 + 3.0 * C.xxx;
    let x1 = x0 - i1 + c.xxx;
    let x2 = x0 - i2 + c.yyy; // 2.0*C.x = 1/3 = C.y
    let x3 = x0 - d.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

    // Permutations
    i = i % 289.0;
    let p = noise_permute_vec4f(
        noise_permute_vec4f(
            noise_permute_vec4f(
                i.z + vec4(0.0, i1.z, i2.z, 1.0)
            ) + i.y + vec4(0.0, i1.y, i2.y, 1.0)
        ) + i.x + vec4(0.0, i1.x, i2.x, 1.0)
    );

    // Gradients: 7x7 points over a square, mapped onto an octahedron.
    // The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
    let n_ = 0.142857142857; // 1.0/7.0
    let ns = n_ * d.wyz - d.xzx;

    let j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

    let x_ = floor(j * ns.z);
    let y_ = floor(j - 7.0 * x_);    // mod(j,N)

    let x = x_ * ns.x + ns.yyyy;
    let y = y_ * ns.x + ns.yyyy;
    let h = 1.0 - abs(x) - abs(y);

    let b0 = vec4(x.xy, y.xy);
    let b1 = vec4(x.zw, y.zw);

    //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
    //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
    let s0 = floor(b0) * 2.0 + 1.0;
    let s1 = floor(b1) * 2.0 + 1.0;
    let sh = -step(h, vec4(0.0));

    let a0 = b0.xzyw + s0.xzyw * sh.xxyy ;
    let a1 = b1.xzyw + s1.xzyw * sh.zzww ;

    var p0 = vec3(a0.xy, h.x);
    var p1 = vec3(a0.zw, h.y);
    var p2 = vec3(a1.xy, h.z);
    var p3 = vec3(a1.zw, h.w);

    //Normalise gradients
    let norm = inverseSqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

    // Mix final noise value
    var m = max(
        0.5 - vec4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)),
        vec4(0.0)
    );
    m = m * m;
    return 105.0 * dot(m * m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

#endif

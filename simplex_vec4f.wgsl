#define_import_path noise::simplex_vec2f

#ifdef UNDEFINED
#import noise::common
#endif

fn noise_simplex_vec4f_gradient(j: f32, ip: vec4<f32>) -> vec4<f32> {
    let ones = vec4(1.0, 1.0, 1.0, -1.0);
    var p: vec4<f32>;
    var s: vec4<f32>;

    p.xyz = floor(fract(vec3(j) * ip.xyz) * 7.0) * ip.z - 1.0;
    p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
    s = vec4<f32>(p < vec4(0.0));
    p.xyz = p.xyz + (s.xyz * 2.0 - 1.0) * s.www;

    return p;
}

fn noise_simplex_vec4f(v: vec4<f32>) -> f32 {
    let c = vec4(
        0.138196601125011,  // (5 - sqrt(5))/20  G4
        0.276393202250021,  // 2 * G4
        0.414589803375032,  // 3 * G4
        -0.447213595499958  // -1 + 4 * G4
    );

    // (sqrt(5) - 1)/4 = F4, used once below
    let f4 = 0.309016994374947451;

    // First corner
    var i = floor(v + dot(v, vec4(f4)));
    let x0 = v - i + dot(i, c.xxxx);

    // Other corners

    // Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
    var i0: vec4<f32>;
    let isX = step(x0.yzw, x0.xxx);
    let isYZ = step(x0.zww, x0.yyz);
    //  i0.x = dot( isX, vec3( 1.0 ) );
    i0.x = isX.x + isX.y + isX.z;
    i0.yzw = 1.0 - isX;
    //  i0.y += dot( isYZ.xy, vec2( 1.0 ) );
    i0.y += isYZ.x + isYZ.y;
    i0.zw += 1.0 - isYZ.xy;
    i0.z += isYZ.z;
    i0.w += 1.0 - isYZ.z;

    // i0 now contains the unique values 0,1,2,3 in each channel
    let i3 = clamp(i0, vec4(0.0), vec4(1.0));
    let i2 = clamp(i0 - 1.0, vec4(0.0), vec4(1.0));
    let i1 = clamp(i0 - 2.0, vec4(0.0), vec4(1.0));

    // x0 = x0 - 0.0 + 0.0 * C.xxxx
    // x1 = x0 - i1  + 1.0 * C.xxxx
    // x2 = x0 - i2  + 2.0 * C.xxxx
    // x3 = x0 - i3  + 3.0 * C.xxxx
    // x4 = x0 - 1.0 + 4.0 * C.xxxx
    let x1 = x0 - i1 + c.xxxx;
    let x2 = x0 - i2 + c.yyyy;
    let x3 = x0 - i3 + c.zzzz;
    let x4 = x0 + c.wwww;

    // Permutations
    i = i % 289.0;
    let j0 = noise_permute_f32(
        noise_permute_f32(
            noise_permute_f32(
                noise_permute_f32(i.w) + i.z
            ) + i.y
        ) + i.x
    );
    let j1 = noise_permute_vec4f(
        noise_permute_vec4f(
            noise_permute_vec4f(
                noise_permute_vec4f(
                    i.w + vec4(i1.w, i2.w, i3.w, 1.0)
                ) + i.z + vec4(i1.z, i2.z, i3.z, 1.0)
            ) + i.y + vec4(i1.y, i2.y, i3.y, 1.0)
        ) + i.x + vec4(i1.x, i2.x, i3.x, 1.0)
    );

    // Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
    // 7*7*6 = 294, which is close to the ring size 17*17 = 289.
    let ip = vec4(1.0 / 294.0, 1.0 / 49.0, 1.0 / 7.0, 0.0) ;

    var p0 = noise_simplex_vec4f_gradient(j0, ip);
    var p1 = noise_simplex_vec4f_gradient(j1.x, ip);
    var p2 = noise_simplex_vec4f_gradient(j1.y, ip);
    var p3 = noise_simplex_vec4f_gradient(j1.z, ip);
    var p4 = noise_simplex_vec4f_gradient(j1.w, ip);

    // Normalise gradients
    let norm = inverseSqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;
    p4 *= inverseSqrt(dot(p4, p4));

    // Mix contributions from the five corners
    var m0 = max(
        0.6 - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2)),
        vec3(0.0)
    );
    var m1 = max(
        0.6 - vec2(dot(x3, x3), dot(x4, x4)),
        vec2(0.0)
    );
    m0 = m0 * m0;
    m1 = m1 * m1;
    return 49.0 * (dot(m0 * m0, vec3(dot(p0, x0), dot(p1, x1), dot(p2, x2))) + dot(m1 * m1, vec2(dot(p3, x3), dot(p4, x4)))) ;
}


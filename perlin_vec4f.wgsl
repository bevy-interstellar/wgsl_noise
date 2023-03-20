#define_import_path noise::perlin_vec4f
#ifndef IMPORT_NOISE_PERLIN_VEC4F
#define IMPORT_NOISE_PERLIN_VEC4F

#import noise::common

// Classic Perlin noise
fn noise_perlin_vec4f(p: vec4<f32>) -> f32 {
    var pi0 = floor(p);     // Integer part for indexing
    var pi1 = pi0 + 1.0;    // Integer part + 1
    pi0 = pi0 % 289.0;
    pi1 = pi1 % 289.0;
    let pf0 = fract(p);     // Fractional part for interpolation
    let pf1 = pf0 - 1.0;    // Fractional part - 1.0
    let ix = vec4(pi0.x, pi1.x, pi0.x, pi1.x);
    let iy = vec4(pi0.yy, pi1.yy);
    let iz0 = vec4(pi0.zzzz);
    let iz1 = vec4(pi1.zzzz);
    let iw0 = vec4(pi0.wwww);
    let iw1 = vec4(pi1.wwww);

    let ixy = noise_permute_vec4f(noise_permute_vec4f(ix) + iy);
    let ixy0 = noise_permute_vec4f(ixy + iz0);
    let ixy1 = noise_permute_vec4f(ixy + iz1);
    let ixy00 = noise_permute_vec4f(ixy0 + iw0);
    let ixy01 = noise_permute_vec4f(ixy0 + iw1);
    let ixy10 = noise_permute_vec4f(ixy1 + iw0);
    let ixy11 = noise_permute_vec4f(ixy1 + iw1);

    var gx00 = ixy00 * (1.0 / 7.0);
    var gy00 = floor(gx00) * (1.0 / 7.0);
    var gz00 = floor(gy00) * (1.0 / 6.0);
    gx00 = fract(gx00) - 0.5;
    gy00 = fract(gy00) - 0.5;
    gz00 = fract(gz00) - 0.5;
    var gw00 = 0.75 - abs(gx00) - abs(gy00) - abs(gz00);
    var sw00 = step(gw00, vec4(0.0));
    gx00 -= sw00 * (step(vec4(0.0), gx00) - 0.5);
    gy00 -= sw00 * (step(vec4(0.0), gy00) - 0.5);

    var gx01 = ixy01 * (1.0 / 7.0);
    var gy01 = floor(gx01) * (1.0 / 7.0);
    var gz01 = floor(gy01) * (1.0 / 6.0);
    gx01 = fract(gx01) - 0.5;
    gy01 = fract(gy01) - 0.5;
    gz01 = fract(gz01) - 0.5;
    let gw01 = 0.75 - abs(gx01) - abs(gy01) - abs(gz01);
    let sw01 = step(gw01, vec4(0.0));
    gx01 -= sw01 * (step(vec4(0.0), gx01) - 0.5);
    gy01 -= sw01 * (step(vec4(0.0), gy01) - 0.5);

    var gx10 = ixy10 * (1.0 / 7.0);
    var gy10 = floor(gx10) * (1.0 / 7.0);
    var gz10 = floor(gy10) * (1.0 / 6.0);
    gx10 = fract(gx10) - 0.5;
    gy10 = fract(gy10) - 0.5;
    gz10 = fract(gz10) - 0.5;
    let gw10 = 0.75 - abs(gx10) - abs(gy10) - abs(gz10);
    let sw10 = step(gw10, vec4(0.0));
    gx10 -= sw10 * (step(vec4(0.0), gx10) - 0.5);
    gy10 -= sw10 * (step(vec4(0.0), gy10) - 0.5);

    var gx11 = ixy11 * (1.0 / 7.0);
    var gy11 = floor(gx11) * (1.0 / 7.0);
    var gz11 = floor(gy11) * (1.0 / 6.0);
    gx11 = fract(gx11) - 0.5;
    gy11 = fract(gy11) - 0.5;
    gz11 = fract(gz11) - 0.5;
    let gw11 = 0.75 - abs(gx11) - abs(gy11) - abs(gz11);
    let sw11 = step(gw11, vec4(0.0));
    gx11 -= sw11 * (step(vec4(0.0), gx11) - 0.5);
    gy11 -= sw11 * (step(vec4(0.0), gy11) - 0.5);

    var g0000 = vec4(gx00.x, gy00.x, gz00.x, gw00.x);
    var g1000 = vec4(gx00.y, gy00.y, gz00.y, gw00.y);
    var g0100 = vec4(gx00.z, gy00.z, gz00.z, gw00.z);
    var g1100 = vec4(gx00.w, gy00.w, gz00.w, gw00.w);
    var g0010 = vec4(gx10.x, gy10.x, gz10.x, gw10.x);
    var g1010 = vec4(gx10.y, gy10.y, gz10.y, gw10.y);
    var g0110 = vec4(gx10.z, gy10.z, gz10.z, gw10.z);
    var g1110 = vec4(gx10.w, gy10.w, gz10.w, gw10.w);
    var g0001 = vec4(gx01.x, gy01.x, gz01.x, gw01.x);
    var g1001 = vec4(gx01.y, gy01.y, gz01.y, gw01.y);
    var g0101 = vec4(gx01.z, gy01.z, gz01.z, gw01.z);
    var g1101 = vec4(gx01.w, gy01.w, gz01.w, gw01.w);
    var g0011 = vec4(gx11.x, gy11.x, gz11.x, gw11.x);
    var g1011 = vec4(gx11.y, gy11.y, gz11.y, gw11.y);
    var g0111 = vec4(gx11.z, gy11.z, gz11.z, gw11.z);
    var g1111 = vec4(gx11.w, gy11.w, gz11.w, gw11.w);

    let norm00 = inverseSqrt(vec4(
        dot(g0000, g0000),
        dot(g0100, g0100),
        dot(g1000, g1000),
        dot(g1100, g1100)
    ));
    g0000 *= norm00.x;
    g0100 *= norm00.y;
    g1000 *= norm00.z;
    g1100 *= norm00.w;

    let norm01 = inverseSqrt(vec4(
        dot(g0001, g0001),
        dot(g0101, g0101),
        dot(g1001, g1001),
        dot(g1101, g1101)
    ));
    g0001 *= norm01.x;
    g0101 *= norm01.y;
    g1001 *= norm01.z;
    g1101 *= norm01.w;

    let norm10 = inverseSqrt(vec4(
        dot(g0010, g0010),
        dot(g0110, g0110),
        dot(g1010, g1010),
        dot(g1110, g1110)
    ));
    g0010 *= norm10.x;
    g0110 *= norm10.y;
    g1010 *= norm10.z;
    g1110 *= norm10.w;

    let norm11 = inverseSqrt(vec4(
        dot(g0011, g0011),
        dot(g0111, g0111),
        dot(g1011, g1011),
        dot(g1111, g1111)
    ));
    g0011 *= norm11.x;
    g0111 *= norm11.y;
    g1011 *= norm11.z;
    g1111 *= norm11.w;

    let n0000 = dot(g0000, pf0);
    let n1000 = dot(g1000, vec4(pf1.x, pf0.yzw));
    let n0100 = dot(g0100, vec4(pf0.x, pf1.y, pf0.zw));
    let n1100 = dot(g1100, vec4(pf1.xy, pf0.zw));
    let n0010 = dot(g0010, vec4(pf0.xy, pf1.z, pf0.w));
    let n1010 = dot(g1010, vec4(pf1.x, pf0.y, pf1.z, pf0.w));
    let n0110 = dot(g0110, vec4(pf0.x, pf1.yz, pf0.w));
    let n1110 = dot(g1110, vec4(pf1.xyz, pf0.w));
    let n0001 = dot(g0001, vec4(pf0.xyz, pf1.w));
    let n1001 = dot(g1001, vec4(pf1.x, pf0.yz, pf1.w));
    let n0101 = dot(g0101, vec4(pf0.x, pf1.y, pf0.z, pf1.w));
    let n1101 = dot(g1101, vec4(pf1.xy, pf0.z, pf1.w));
    let n0011 = dot(g0011, vec4(pf0.xy, pf1.zw));
    let n1011 = dot(g1011, vec4(pf1.x, pf0.y, pf1.zw));
    let n0111 = dot(g0111, vec4(pf0.x, pf1.yzw));
    let n1111 = dot(g1111, pf1);

    let fade_xyzw = noise_fade_vec4f(pf0);
    let n_0w = mix(
        vec4(n0000, n1000, n0100, n1100),
        vec4(n0001, n1001, n0101, n1101),
        fade_xyzw.w
    );
    let n_1w = mix(
        vec4(n0010, n1010, n0110, n1110),
        vec4(n0011, n1011, n0111, n1111),
        fade_xyzw.w
    );
    let n_zw = mix(n_0w, n_1w, fade_xyzw.z);
    let n_yzw = mix(n_zw.xy, n_zw.zw, fade_xyzw.y);
    let n_xyzw = mix(n_yzw.x, n_yzw.y, fade_xyzw.x);

    return 2.2 * n_xyzw;
}

#endif

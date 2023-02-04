#define_import_path noise::perlin_vec2f

fn noise_perlin_vec2f(p: vec2<f32>) -> f32 {
    var pi = floor(p.xyxy) + vec4<f32>(0.0, 0.0, 1.0, 1.0);
    pi = pi % 289.0;    // to avoid trauncation effects in permutation

    let pf = fract(p.xyxy) - vec4<f32>(0.0, 0.0, 1.0, 1.0);

    let ix = pi.xzxz;
    let iy = pi.yyww;
    let fx = pf.xzxz;
    let fy = pf.yyww;

    let i = noise_permute_vec4f(noise_permute_vec4f(ix) + iy);

    var gx = fract(i * (1.0 / 41.0)) * 2.0 - 1.0;
    let gy = abs(gx) - 0.5 ;
    let tx = floor(gx + 0.5);
    gx = gx - tx;

    var g00 = vec2<f32>(gx.x, gy.x);
    var g10 = vec2<f32>(gx.y, gy.y);
    var g01 = vec2<f32>(gx.z, gy.z);
    var g11 = vec2<f32>(gx.w, gy.w);

    let norm = inverseSqrt(vec4<f32>(
        dot(g00, g00),
        dot(g01, g01),
        dot(g10, g10),
        dot(g11, g11)
    ));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;

    let n00 = dot(g00, vec2<f32>(fx.x, fy.x));
    let n10 = dot(g10, vec2<f32>(fx.y, fy.y));
    let n01 = dot(g01, vec2<f32>(fx.z, fy.z));
    let n11 = dot(g11, vec2<f32>(fx.w, fy.w));

    let fade_xy = noise_fade_vec2f(pf.xy);
    let n_x = mix(vec2<f32>(n00, n01), vec2<f32>(n10, n11), fade_xy.x);
    let n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return 2.3 * n_xy;
}

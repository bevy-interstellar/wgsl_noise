#define_import_path noise::simplex_vec2f

#ifdef UNDEFINED
#import noise::common
#endif

fn noise_simplex_vec2f(v: vec2<f32>) -> f32 {
    let c = vec4(
        0.211324865405187,      // (3.0-sqrt(3.0))/6.0
        0.366025403784439,      // 0.5*(sqrt(3.0)-1.0)
        -0.577350269189626,     // -1.0 + 2.0 * C.x
        0.024390243902439       // 1.0 / 41.0
    );
    
    // First corner
    var i = floor(v + dot(v, c.yy));
    let x0 = v - i + dot(i, c.xx);

    // Other corners
    var i1: vec2<f32>;
    // i1.x = step( x0.y, x0.x ); = x0.x > x0.y ? 1.0 : 0.0
    // i1.y = 1.0 - i1.x;
    if x0.x > x0.y {
        i1 = vec2(1.0, 0.0);
    } else {
        i1 = vec2(0.0, 1.0);
    }

    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    var x12 = x0.xyxy + c.xxzz;
    let sw0 = x12.xy - i1;
    x12.x = sw0.x;
    x12.y = sw0.y;

    // Permutations
    i = i % 289.0;          // Avoid truncation effects in permutation
    let p = noise_permute_vec3f(
        noise_permute_vec3f(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0)
    );

    var m = max(
        0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)),
        vec3(0.0)
    );
    m = m * m ;
    m = m * m ;

    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)
    let x = 2.0 * fract(p * c.www) - 1.0;
    let h = abs(x) - 0.5;
    let ox = floor(x + 0.5);
    let a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

    // Compute final noise value at P
    var g: vec3<f32>;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.y = a0.y * x12.x + h.y * x12.y;
    g.z = a0.z * x12.z + h.z * x12.w;
    return 130.0 * dot(m, g);
}


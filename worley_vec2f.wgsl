#define_import_path noise::worley_vec2f

#ifdef UNDEFINED
#import noise::common
#endif

fn noise_worley_vec2f(p: vec2<f32>) -> vec2<f32> {
    let k = 0.142857142857;     // 1/7
    let ko = 0.428571428571;    // 3/7
    let jitter = 1.0;           // Less gives more regular pattern

    let pi = floor(p) % 289.0;
    let pf = fract(p);
    let oi = vec3(-1.0, 0.0, 1.0);
    let of = vec3(-0.5, 0.5, 1.5);
    let px = noise_permute_vec3f(pi.x + oi);
    var p = noise_permute_vec3f(px.x + pi.y + oi);  // p11, p12, p13
    var ox = fract(p * k) - ko;
    var oy = (floor(p * k) % 7.0) * k - ko;
    var dx = pf.x + 0.5 + jitter * ox;
    var dy = pf.y - of + jitter * oy;
    var d1 = dx * dx + dy * dy;     // d11, d12 and d13, squared
    p = noise_permute_vec3f(px.y + pi.y + oi);      // p21, p22, p23
    ox = fract(p * k) - ko;
    oy = (floor(p * k) % 7.0) * k - ko;
    dx = pf.x - 0.5 + jitter * ox;
    dy = pf.y - of + jitter * oy;
    var d2 = dx * dx + dy * dy;     // d21, d22 and d23, squared
    p = noise_permute_vec3f(px.z + pi.y + oi);      // p31, p32, p33
    ox = fract(p * k) - ko;
    oy = (floor(p * k) % 7.0) * k - ko;
    dx = pf.x - 1.5 + jitter * ox;
    dy = pf.y - of + jitter * oy;
    let d3 = dx * dx + dy * dy;     // d31, d32 and d33, squared
	
    // Sort out the two smallest distances (F1, F2)
    let d1a = min(d1, d2);
    d2 = max(d1, d2);               // Swap to keep candidates for F2
    d2 = min(d2, d3);               // neither F1 nor F2 are now in d3
    d1 = min(d1a, d2);              // F1 is now in d1
    d2 = max(d1a, d2);              // Swap to keep candidates for F2

    if d1.x > d1.y {                // Swap if smaller
        d1.x = d1.y
        d1.y = d1.x
    }
    if d1.x > d1.z {                // F1 is in d1.x
        d1.x = d1.z;
        d1.z = d1.x;
    }

    d1.y = min(d1.y, d2.y);         // F2 is now not in d2.yz
    d1.z = min(d1.z, d2.z);
    d1.y = min(d1.y, d1.z);         // nor in  d1.z
    d1.y = min(d1.y, d2.x);         // F2 is in d1.y, we're done.
    return sqrt(d1.xy);
}

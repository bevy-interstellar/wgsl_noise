#define_import_path noise::worley_vec3f

#ifdef UNDEFINED
#import noise::common
#endif

fn noise_worley_vec3f(v: vec3<f32>) -> vec2<f32> {
    let k = 0.142857142857;     // 1/7
    let ko = 0.428571428571;    // 1/2-k/2
    let k2 = 0.020408163265306; // 1/(7*7)
    let kz = 0.166666666667;    // 1/6
    let kzo = 0.416666666667;   // 1/2-1/6*2
    let jitter = 1.0;           // smaller jitter gives more regular pattern

    let pi = floor(v) % 289.0;
    let pf = fract(v) - 0.5;

    let pfx = pf.x + vec3(1.0, 0.0, -1.0);
    let pfy = pf.y + vec3(1.0, 0.0, -1.0);
    let pfz = pf.z + vec3(1.0, 0.0, -1.0);

    let p = noise_permute_vec3f(pi.x + vec3(-1.0, 0.0, 1.0));
    let p1 = noise_permute_vec3f(p + pi.y - 1.0);
    let p2 = noise_permute_vec3f(p + pi.y);
    let p3 = noise_permute_vec3f(p + pi.y + 1.0);

    let p11 = noise_permute_vec3f(p1 + pi.z - 1.0);
    let p12 = noise_permute_vec3f(p1 + pi.z);
    let p13 = noise_permute_vec3f(p1 + pi.z + 1.0);

    let p21 = noise_permute_vec3f(p2 + pi.z - 1.0);
    let p22 = noise_permute_vec3f(p2 + pi.z);
    let p23 = noise_permute_vec3f(p2 + pi.z + 1.0);

    let p31 = noise_permute_vec3f(p3 + pi.z - 1.0);
    let p32 = noise_permute_vec3f(p3 + pi.z);
    let p33 = noise_permute_vec3f(p3 + pi.z + 1.0);

    let ox11 = fract(p11 * k) - ko;
    let oy11 = (floor(p11 * k) % 7.0) * k - ko;
    let oz11 = floor(p11 * k2) * kz - kzo;  // p11 < 289 guaranteed

    let ox12 = fract(p12 * k) - ko;
    let oy12 = (floor(p12 * k) % 7.0) * k - ko;
    let oz12 = floor(p12 * k2) * kz - kzo;

    let ox13 = fract(p13 * k) - ko;
    let oy13 = (floor(p13 * k) % 7.0) * k - ko;
    let oz13 = floor(p13 * k2) * kz - kzo;

    let ox21 = fract(p21 * k) - ko;
    let oy21 = (floor(p21 * k) % 7.0) * k - ko;
    let oz21 = floor(p21 * k2) * kz - kzo;

    let ox22 = fract(p22 * k) - ko;
    let oy22 = (floor(p22 * k) % 7.0) * k - ko;
    let oz22 = floor(p22 * k2) * kz - kzo;

    let ox23 = fract(p23 * k) - ko;
    let oy23 = (floor(p23 * k) % 7.0) * k - ko;
    let oz23 = floor(p23 * k2) * kz - kzo;

    let ox31 = fract(p31 * k) - ko;
    let oy31 = (floor(p31 * k) % 7.0) * k - ko;
    let oz31 = floor(p31 * k2) * kz - kzo;

    let ox32 = fract(p32 * k) - ko;
    let oy32 = (floor(p32 * k) % 7.0) * k - ko;
    let oz32 = floor(p32 * k2) * kz - kzo;

    let ox33 = fract(p33 * k) - ko;
    let oy33 = (floor(p33 * k) % 7.0) * k - ko;
    let oz33 = floor(p33 * k2) * kz - kzo;

    let dx11 = pfx + jitter * ox11;
    let dy11 = pfy.x + jitter * oy11;
    let dz11 = pfz.x + jitter * oz11;

    let dx12 = pfx + jitter * ox12;
    let dy12 = pfy.x + jitter * oy12;
    let dz12 = pfz.y + jitter * oz12;

    let dx13 = pfx + jitter * ox13;
    let dy13 = pfy.x + jitter * oy13;
    let dz13 = pfz.z + jitter * oz13;

    let dx21 = pfx + jitter * ox21;
    let dy21 = pfy.y + jitter * oy21;
    let dz21 = pfz.x + jitter * oz21;

    let dx22 = pfx + jitter * ox22;
    let dy22 = pfy.y + jitter * oy22;
    let dz22 = pfz.y + jitter * oz22;

    let dx23 = pfx + jitter * ox23;
    let dy23 = pfy.y + jitter * oy23;
    let dz23 = pfz.z + jitter * oz23;

    let dx31 = pfx + jitter * ox31;
    let dy31 = pfy.z + jitter * oy31;
    let dz31 = pfz.x + jitter * oz31;

    let dx32 = pfx + jitter * ox32;
    let dy32 = pfy.z + jitter * oy32;
    let dz32 = pfz.y + jitter * oz32;

    let dx33 = pfx + jitter * ox33;
    let dy33 = pfy.z + jitter * oy33;
    let dz33 = pfz.z + jitter * oz33;

    var d11 = dx11 * dx11 + dy11 * dy11 + dz11 * dz11;
    var d12 = dx12 * dx12 + dy12 * dy12 + dz12 * dz12;
    var d13 = dx13 * dx13 + dy13 * dy13 + dz13 * dz13;
    var d21 = dx21 * dx21 + dy21 * dy21 + dz21 * dz21;
    var d22 = dx22 * dx22 + dy22 * dy22 + dz22 * dz22;
    var d23 = dx23 * dx23 + dy23 * dy23 + dz23 * dz23;
    var d31 = dx31 * dx31 + dy31 * dy31 + dz31 * dz31;
    var d32 = dx32 * dx32 + dy32 * dy32 + dz32 * dz32;
    var d33 = dx33 * dx33 + dy33 * dy33 + dz33 * dz33;

	// Sort out the two smallest distances (F1, F2)
#ifdef WORLEY_IGNORE_F2
    let d1 = min(min(d11, d12), d13);
    let d2 = min(min(d21, d22), d23);
    let d3 = min(min(d31, d32), d33);
    let d = min(min(d1, d2), d3);
    d.x = min(min(d.x, d.y), d.z);
    return vec2(sqrt(d.x)); // F1 duplicated, no F2 computed
#else
	// Do it right and sort out both F1 and F2
    let d1a = min(d11, d12);
    d12 = max(d11, d12);
    d11 = min(d1a, d13);        // Smallest now not in d12 or d13
    d13 = max(d1a, d13);
    d12 = min(d12, d13);        // 2nd smallest now not in d13
    let d2a = min(d21, d22);
    d22 = max(d21, d22);
    d21 = min(d2a, d23);        // Smallest now not in d22 or d23
    d23 = max(d2a, d23);
    d22 = min(d22, d23);        // 2nd smallest now not in d23
    let d3a = min(d31, d32);
    d32 = max(d31, d32);
    d31 = min(d3a, d33);        // Smallest now not in d32 or d33
    d33 = max(d3a, d33);
    d32 = min(d32, d33);        // 2nd smallest now not in d33
    let da = min(d11, d21);
    d21 = max(d11, d21);
    d11 = min(da, d31);         // Smallest now in d11
    d31 = max(da, d31);         // 2nd smallest now not in d31
    if d11.x > d11.y {
        let tmp = d11.x;
        d11.x = d11.y;
        d11.y = tmp;
    }
    if d11.x > d11.z {          // d11.x now smallest

        let tmp = d11.x;
        d11.x = d11.z;
        d11.z = tmp;
    }
    d12 = min(d12, d21);        // 2nd smallest now not in d21
    d12 = min(d12, d22);        // nor in d22
    d12 = min(d12, d31);        // nor in d31
    d12 = min(d12, d32);        // nor in d32
    d11.y = min(d11.y, d12.x);
    d11.z = min(d11.z, d12.y);  // nor in d12.yz
    d11.y = min(d11.y, d12.z);  // Only two more to go
    d11.y = min(d11.y, d11.z);  // Done! (phew!)
    return sqrt(d11.xy);        // F1, F2
#endif
}

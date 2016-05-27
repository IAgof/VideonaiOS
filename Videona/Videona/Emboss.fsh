varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
void main() {
    lowp vec3 irgb = texture2D(inputImageTexture, textureCoordinate).rgb;
    highp float ResS = 720.;
    highp float ResT = 720.;
    lowp vec2 stp0 = vec2(1./ResS, 0.);
    lowp vec2 stpp = vec2(1./ResS, 1./ResT);
    lowp vec3 c00 = texture2D(inputImageTexture, textureCoordinate).rgb;
    lowp vec3 cp1p1 = texture2D(inputImageTexture, textureCoordinate + stpp).rgb;
    lowp vec3 diffs = c00 - cp1p1;
    highp float max = diffs.r;
    if(abs(diffs.g)>abs(max)) max = diffs.g;
    if(abs(diffs.b)>abs(max)) max = diffs.b;
    highp float gray = clamp(max + .5, 0., 1.);
    lowp vec3 color = vec3(gray, gray, gray);
    gl_FragColor = vec4(mix(color,c00, 0.1), 1.);
}
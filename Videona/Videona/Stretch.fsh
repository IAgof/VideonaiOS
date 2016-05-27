varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform lowp vec2 uPosition;
void main() {
    lowp vec2 texCoord = textureCoordinate.xy;
    lowp vec2 normCoord = 2.0 * texCoord - 1.0;
    lowp vec2 s = sign(normCoord + uPosition);
    normCoord = abs(normCoord);
    normCoord = 0.5 * normCoord + 0.5 * smoothstep(0.25, 0.5, normCoord) * normCoord;
    normCoord = s * normCoord;
    texCoord = normCoord / 2.0 + 0.5;
    gl_FragColor = texture2D(inputImageTexture, texCoord);
}
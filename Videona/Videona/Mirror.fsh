varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform lowp vec2 uPosition;

void main() {
    lowp vec2 texCoord = textureCoordinate.xy;
    lowp vec2 normCoord = 2.0 * texCoord - 1.0;
    normCoord.x = normCoord.x * sign(normCoord.x + uPosition.x);
    texCoord = normCoord / 2.0 + 0.5;
    gl_FragColor = texture2D(inputImageTexture, texCoord);\
}
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform lowp vec2 uPosition;

void main() {
    lowp vec2 texCoord = textureCoordinate.xy;
    lowp vec2 normCoord = 2.0 * texCoord - 1.0;
    highp float r = length(normCoord); // to polar coords
    highp float phi = atan(normCoord.y + uPosition.y, normCoord.x + uPosition.x); // to polar coords
    phi = phi + (1.0 - smoothstep(-0.5, 0.5, r)) * 4.0; // Twirl it
    normCoord.x = r * cos(phi); 
    normCoord.y = r * sin(phi); 
    texCoord = normCoord / 2.0 + 0.5;
    gl_FragColor = texture2D(inputImageTexture, texCoord);
}
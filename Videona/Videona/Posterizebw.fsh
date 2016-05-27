varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform  lowp  vec2 uPosition;
void main() {
    lowp vec4 color = texture2D(inputImageTexture, textureCoordinate.st);
    highp float luminance = 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
    if (luminance < 0.5) gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    else gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
void main()
{
lowp vec4 outColor = texture2D(inputImageTexture, textureCoordinate.st);
highp float level = 5.0;
outColor.r = floor(outColor.r * level) / level;
outColor.g = floor(outColor.g * level) / level;
outColor.b = floor(outColor.b * level) / level;
gl_FragColor = outColor;
}
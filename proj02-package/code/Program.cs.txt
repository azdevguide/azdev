using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;

const int THUMB_SIZE = 100;
using var image = Image.Load("input.jpg");
image.Mutate(context => context.Resize(THUMB_SIZE, THUMB_SIZE));
image.SaveAsPng("output.png");
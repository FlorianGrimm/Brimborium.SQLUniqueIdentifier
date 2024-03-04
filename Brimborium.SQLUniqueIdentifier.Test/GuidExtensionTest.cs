namespace Brimborium.Test;

public class GuidExtensionTest
{
    [Fact]
    public void Test01()
    {
        Guid act1 = Brimborium.SQLUniqueIdentifier.NewGuidWithTime();
        Assert.Equal("-81", act1.ToString().Substring(23, 3));
        System.Threading.Thread.Sleep(1);
        Guid act2 = Brimborium.SQLUniqueIdentifier.NewGuidWithTime();
        Assert.Equal("-81", act2.ToString().Substring(23, 3));
        Assert.NotEqual(act1.ToString().Substring(0, 24), act2.ToString().Substring(0, 24));
        Assert.Equal(act1.ToString().Substring(24, 5), act2.ToString().Substring(24, 5));
        Assert.True(
            long.Parse( act1.ToString()[24..], System.Globalization.NumberStyles.HexNumber)<
            long.Parse( act2.ToString()[24..], System.Globalization.NumberStyles.HexNumber));
    }
}
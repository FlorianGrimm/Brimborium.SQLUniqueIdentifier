namespace Brimborium;

public static class SQLUniqueIdentifier
{
    public static Guid NewGuidWithTime()
    {
        var uuid = Guid.NewGuid();
        DateTime dt = DateTime.UtcNow;
        var msTicks = 0x800000000000
            | ((dt.Ticks - 621355968000000000) / 10000);
        Span<byte> span = stackalloc byte[16];
        if (!uuid.TryWriteBytes(span)) throw new InvalidOperationException();
        span[15] = (byte)(msTicks & 0xff);
        span[14] = (byte)((msTicks >> 8) & 0xff);
        span[13] = (byte)((msTicks >> 16) & 0xff);
        span[12] = (byte)((msTicks >> 24) & 0xff);
        span[11] = (byte)((msTicks >> 32) & 0xff);
        span[10] = (byte)((msTicks >> 40) & 0xff);
        return new Guid(span);
    }
}

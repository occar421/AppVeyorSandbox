using Xunit;

namespace Analyzer1.Test
{
	public class XUnitTests
	{
		[Fact]
		public void SuccessTest()
		{
			Assert.True(true);
		}

		[Fact]
		public void FailTest()
		{
			Assert.False(false);
		}
	}
}
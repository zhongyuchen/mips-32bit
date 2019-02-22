#include <string>
#include <iostream>
#include <fstream>

using namespace std;

int main()
{
	fstream infile, outfile;
	infile.open("hanoi.txt");
	outfile.open("hanoi.dat");
	string s;
	int i;
	bool sign;
	while (infile.good())
	{
		infile >> s;
		sign = 0;
		if (s.length() == 8)
		{
			for (i = 0; i < 8; i++)
				if ((s[i]<'0'||s[i]>'9')&&(s[i]<'a'||s[i]>'f'))
					sign = 1;
			if (sign == 0)
				outfile << s << endl;
		}
	}
	
	return 0;
}
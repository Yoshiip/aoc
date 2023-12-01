#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;


vector<char> digits = { '1', '2', '3', '4', '5', '6', '7', '8', '9' };
vector<string> text_digits = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

// for part 2
int check_digit(string line, int base_i) {
    for (int j = 0; j < text_digits.size(); j++)
    {
        string substr_line = line.substr(base_i, min(text_digits.at(j).size(), line.length() - base_i));
        if(text_digits.at(j) == substr_line) {
            return j + 1;
        }
    }
    return -1; // not found
}


int main() {
    int sum = 0;
    vector<int> integers;


    ifstream input("input.txt");

    string line;

    while (getline(input, line)) {
        for (int i = 0; i < line.length(); i++)
        {
            if((std::find(digits.begin(), digits.end(), line.at(i)) != digits.end())) { // if char is a digit
                integers.push_back(line.at(i) - '0');
            }

            // checking for text digit
            int result = check_digit(line, i);
            if(result != -1) {
                integers.push_back(result);
            }

        }
        reverse(integers.begin(), integers.end());
        sum += integers.back() * 10 + integers.front();
        integers.clear();
    }



    input.close();
    

    std::cout << sum << std::endl;
}
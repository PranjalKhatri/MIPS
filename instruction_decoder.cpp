#include <bits/stdc++.h>

// Maps for instruction fields
std::unordered_map<int, std::string> opcodeMap = {
    {0b000000, "R"}, {0b100011, "lw"}, {0b101011, "sw"}, {0b000100, "beq"}, {0b000010, "j"}, {0b000011, "jal"}};

std::unordered_map<int, std::string> functMap = {
    {0b100100, "and"}, {0b100010, "sub"}, {0b100000, "add"}, {0b100101, "or"}, {0b101010, "slt"}};

std::unordered_map<int, std::string> registerMap = {
    {0, "$zero"}, {1, "$at"}, {2, "$v0"}, {3, "$v1"}, {4, "$a0"}, {5, "$a1"}, {6, "$a2"}, {7, "$a3"}, {8, "$t0"}, {9, "$t1"}, {10, "$t2"}, {11, "$t3"}, {12, "$t4"}, {13, "$t5"}, {14, "$t6"}, {15, "$t7"}, {16, "$s0"}, {17, "$s1"}, {18, "$s2"}, {19, "$s3"}, {20, "$s4"}, {21, "$s5"}, {22, "$s6"}, {23, "$s7"}, {24, "$t8"}, {25, "$t9"}, {26, "$k0"}, {27, "$k1"}, {28, "$gp"}, {29, "$sp"}, {30, "$fp"}, {31, "$ra"}};
std::unordered_map<std::string, std::string> reverseOpCodeMap = {
    {"R", "000000"}, {"add", "000000"}, {"or", "000000"}, {"and", "000000"}, {"slt", "000000"}, {"lw", "100011"}, {"sw", "101011"}, {"beq", "000100"}, {"j", "000010"}, {"jal", "000011"}};

std::unordered_map<std::string, std::string> reverseFunctMap = {
    {"and", "100100"}, {"sub", "100010"}, {"add", "100000"}, {"or", "100101"}, {"slt", "101010"}};
std::unordered_map<std::string, std::string> reverseRegisterMap;

void decodeInstruction(uint32_t instruction)
{
    // Extract fields from the instruction
    int opcode = (instruction >> 26) & 0x3F; // bits 31-26
    int rs = (instruction >> 21) & 0x1F;     // bits 25-21
    int rt = (instruction >> 16) & 0x1F;     // bits 20-16
    int rd = (instruction >> 11) & 0x1F;     // bits 15-11
    int shamt = (instruction >> 6) & 0x1F;   // bits 10-6
    int funct = instruction & 0x3F;          // bits 5-0
    int immediate = instruction & 0xFFFF;    // bits 15-0
    int address = instruction & 0x3FFFFFF;   // bits 25-0

    // Sign-extend immediate if needed
    int16_t signedImm = static_cast<int16_t>(immediate);
    int32_t extendedImm = static_cast<int32_t>(signedImm);

    std::cout << "Instruction: 0x" << std::hex << std::setw(8) << std::setfill('0') << instruction << std::dec << std::endl;
    std::cout << "Binary: " << std::bitset<32>(instruction).to_string() << std::endl;
    std::cout << "Opcode: " << opcode << " (" << (opcodeMap.count(opcode) ? opcodeMap[opcode] : "unknown") << ")" << std::endl;

    // Decode based on opcode
    if (opcode == 0)
    { // R-type instruction
        std::cout << "R-type instruction" << std::endl;
        std::cout << "rs: " << rs << " (" << registerMap[rs] << ")" << std::endl;
        std::cout << "rt: " << rt << " (" << registerMap[rt] << ")" << std::endl;
        std::cout << "rd: " << rd << " (" << registerMap[rd] << ")" << std::endl;
        std::cout << "shamt: " << shamt << std::endl;
        std::cout << "funct: " << funct << " (" << (functMap.count(funct) ? functMap[funct] : "unknown") << ")" << std::endl;

        // Format the assembly instruction
        if (funct == 0 || funct == 2 || funct == 3)
        { // shift instructions
            std::cout << "Assembly: " << functMap[funct] << " " << registerMap[rd] << ", " << registerMap[rt] << ", " << shamt << std::endl;
        }
        else if (funct == 8)
        { // jr
            std::cout << "Assembly: " << functMap[funct] << " " << registerMap[rs] << std::endl;
        }
        else
        { // Most other R-type instructions
            std::cout << "Assembly: " << functMap[funct] << " " << registerMap[rd] << ", " << registerMap[rs] << ", " << registerMap[rt] << std::endl;
        }
    }
    else if (opcode == 2 || opcode == 3)
    { // J-type instruction (j, jal)
        std::cout << "J-type instruction" << std::endl;
        std::cout << "address: 0x" << std::hex << address << std::dec << std::endl;
        std::cout << "Assembly: " << opcodeMap[opcode] << " 0x" << std::hex << (address << 2) << std::dec << std::endl;
    }
    else
    { // I-type instruction
        std::cout << "I-type instruction" << std::endl;
        std::cout << "rs: " << rs << " (" << registerMap[rs] << ")" << std::endl;
        std::cout << "rt: " << rt << " (" << registerMap[rt] << ")" << std::endl;
        std::cout << "immediate: " << immediate << " (0x" << std::hex << immediate << std::dec << ")" << std::endl;
        std::cout << "signed immediate: " << extendedImm << std::endl;

        // Format the assembly instruction
        if (opcode == 4 || opcode == 5)
        { // beq, bne
            std::cout << "Assembly: " << opcodeMap[opcode] << " " << registerMap[rs] << ", " << registerMap[rt] << ", " << extendedImm << std::endl;
        }
        else if (opcode >= 32 && opcode <= 43)
        { // load/store
            std::cout << "Assembly: " << opcodeMap[opcode] << " " << registerMap[rt] << ", " << extendedImm << "(" << registerMap[rs] << ")" << std::endl;
        }
        else
        { // Other I-type
            std::cout << "Assembly: " << opcodeMap[opcode] << " " << registerMap[rt] << ", " << registerMap[rs] << ", " << extendedImm << std::endl;
        }
    }
}
std::string trim(const std::string &str)
{
    auto start = std::find_if_not(str.begin(), str.end(), ::isspace);
    auto end = std::find_if_not(str.rbegin(), str.rend(), ::isspace).base();

    if (start >= end)
        return ""; // All spaces
    return std::string(start, end);
}
std::vector<std::string> tokenize(const std::string &str, char delimiter)
{
    std::vector<std::string> tokens;
    std::stringstream ss(str);
    std::string token;

    while (std::getline(ss, token, delimiter))
    {
        tokens.push_back(trim(token));
    }

    return tokens;
}

std::string formatInstruction(const std::string &bin_str)
{
    std::ostringstream oss;
    oss << std::setw(8) << std::setfill('0') << std::hex
        << std::bitset<32>(bin_str).to_ulong();
    return oss.str();
}

std::vector<std::string> encode(std::vector<std::string> instructions)
{
    using namespace std;

    int instruction_number = 0;
    // unordered_map<string, int> label_map;
    string shamt = "00000";
    std::vector<std::string> res;
    for (auto &instruction : instructions)
    {
        string bin_str;
        auto tknized = tokenize(instruction, ',');
        for (auto i : tknized)
            cout << i << endl;
        bin_str += reverseOpCodeMap[tknized[0]];
        cout << "after opcode " << bin_str << "\n";
        switch (tknized.size())
        {
        case 2:                    // jump label, jal label
            bin_str += tknized[1]; // Jump address
            break;

        case 4: // beq and r type instructions and lw  sw
            if (tknized[0] == "lw" || tknized[0] == "sw")
            {

                bin_str += reverseRegisterMap[tknized[2]];
                bin_str += reverseRegisterMap[tknized[1]];
                cout << "lw\\ sw " << bin_str << "\n";
                bin_str += tknized[3]; // users resonsibility
            }
            else if (tknized[0] != "beq")
            {
                bin_str += reverseRegisterMap[tknized[2]];
                bin_str += reverseRegisterMap[tknized[3]];
                bin_str += reverseRegisterMap[tknized[1]];
                bin_str += shamt;
                bin_str += reverseFunctMap[tknized[0]];
            }
            else
            {
                bin_str += reverseRegisterMap[tknized[1]];
                bin_str += reverseRegisterMap[tknized[2]];
                bin_str += tknized[3];
            }
            break;

        default:
            cerr << "Instruction not supported";
            break;
        }
        instruction_number++;
        cout << "encoded instruction " << bin_str << " 0x"
             << std::setw(8) << std::setfill('0') << std::hex << std::bitset<32>(bin_str).to_ulong() << "\n";
        string rs = formatInstruction(bin_str);
        res.push_back(rs);
    }
    return res;
}

std::vector<std::string> parseFile()
{
    using namespace std;
    string fn;
    cout << "file name?\n";
    cin >> fn;
    std::ifstream in(fn);
    std::ofstream out(fn + ".bin");
    if (!in || !out)
    {
        std::cerr << "Error: could not open file " << fn << " or " << fn + ".bin" << "\n";
        exit(1);
    }

    std::string buf;
    std::vector<std::string> lines;

    while (std::getline(in, buf))
    {
        if (trim(buf).substr(0, 2) != "//" && buf.length() > 5)
            lines.push_back(buf);                  // store or process line
        std::cout << "Read line: " << buf << "\n"; // optional
    }

    auto res = encode(lines);
    for (auto i : res)
    {
        out << i<<"\n";
    }
    out.close();
    in.close();
    return res;
}

int main()
{

    for (const auto &pair : registerMap)
    {
        int regNumber = pair.first;
        std::string regName = pair.second;
        reverseRegisterMap[regName] = std::bitset<5>(regNumber).to_string(); // 5-bit binary
    }
loop:
    std::cout << "decode?\n";
    int t;
    std::cin >> t;
    if (t)
    {
        std::string input;
        uint32_t instruction;

        std::cout << "Enter 8-character hex MIPS instruction (e.g., 0C000000): ";
        std::cin >> input;

        try
        {
            // Convert hex string to uint32_t
            instruction = std::stoul(input, nullptr, 16);
            decodeInstruction(instruction);
        }
        catch (const std::exception &e)
        {
            std::cerr << "Error: Invalid instruction format. Please enter a valid 8-character hex value." << std::endl;
            return 1;
        }
    }
    else
    {
        std::string str;
        std::cout << "parseFile ?\n";
        int ans;
        std::cin >> ans;
        if (ans)
            parseFile();
        else
        {
            std::cout << "enter input encoding\n";
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            std::cin.clear();
            std::getline(std::cin, str);

            auto res = encode({str});
            std::cout << res[0] << "\n decoded\n";
        }
    }
    std::cout << "continue? ";
    int a;
    std::cin >> a;
    if (a)
        goto loop;
    return 0;
}
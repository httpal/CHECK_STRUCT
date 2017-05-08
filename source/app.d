import std.stdio;
import std.file;
import std.string;
import std.encoding;
import std.conv;
import std.algorithm;
import std.array;
import funcs;


int main(string[] args){
	//args = ["check_struct", "E:/dbf_files/town/TMP/T0141802141.TXT", "E:/dbf_files/town/FORMAT/UPTOW.dat", ""];
	//args = ["check_struct", "E:/dbf_files/town/TMP/F0200306141.txt", "E:/dbf_files/town/FORMAT/xml11_temp_el_polis.dat", "|2|"];
	//args = ["check_struct", "E:/dbf_files/galmel/ctmp/P613140514.TXT", "E:/dbf_files/galmel/FORMATFILE/RCLINUP1.dat",""];
	
	//args = ["check_struct", "E:/dbf_files/galmel/ctmp/P5671607011.TXT", "E:/dbf_files/galmel/FORMATFILE/RCLINUP1.dat","|2|"];
	//args = ["check_struct", "E:/dbf_files/galmel/ctmp/P0521607011.TXT", "E:/dbf_files/galmel/FORMATFILE/RCLINUP1.dat","|2|"];
	
	//args = ["check_struct", "E:/dbf_files/galmel/ctmp/P935160325003.TXT", "E:/dbf_files/galmel/FORMATFILE/RCLINUP1.dat",""];
	//args = ["check_struct", "E:/h650140601bra/h650140601bra.txt", "E:/dbf_files/galmel/FORMATFILE/RHOSPUP1.dat","|2|"];
	//args = ["check_struct", "E:/DBF_Files/galmel/tmp/H622160301_.TXT", "E:/dbf_files/galmel/FORMATFILE/RHOSPUP1.dat","|2|"];

	string fl_txt = args[1].toUpper;
	string fl_struct = args[2].toUpper;
	string prmtrs = args[3].toUpper;

	auto fldr_txt = fl_txt[0..std.string.lastIndexOf(fl_txt, "/")+1].toUpper;
	auto fldr_struct = fl_struct[0..std.string.lastIndexOf(fl_struct, "/")+1].toUpper;

	// Проверим существование заданных директорий и файлов и права на них
	assert(DirEntry(fldr_txt).isDir);
	assert(DirEntry(fldr_struct).isDir);
	
	assert(DirEntry(fl_txt).isFile);
	assert(DirEntry(fl_struct).isFile);
	
	// Откроем файл структуры в символьную строку
	string fl_struct_str = readText(fl_struct);	

	// Откроем побайтово txt файл
	void[] void_str = std.file.read(fl_txt);
	ubyte[] ubyte_str = cast(ubyte[])void_str;
	
	// Вызов функции проверки
	string name_err_file = "__err_value.txt";
	int return_value = 0;
	string answer_str = "";
	int result = 0;			

	result = check_file(ubyte_str,fl_struct_str,answer_str,return_value,prmtrs,"");
	if (result == 0 ) {
		if (return_value > 0) {
			writeln(UTF8_CP866(answer_str));
			std.file.write(fldr_txt~name_err_file,UTF8_CP1251(answer_str));
			return return_value;
			}
		}
	else {
		writeln("Error of function \"check_file\"");
		return 1;
		}

	//ubyte_str = replace(ubyte_str, [13,10], cast(ubyte[]) [9,9,9,9,9,13,10]);
	std.file.write(fl_txt, ubyte_str);
	return 0;
}

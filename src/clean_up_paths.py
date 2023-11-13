import sys
import glob

def clean_up_paths(input_prefix, path_to_remove):
    pattern = f"{input_file_prefix}*"
    weird_files=0
    for input_file in glob.glob(pattern):
        output_file = "new-"+input_file
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile, open(input_prefix+"_error.log", 'w') as error_log:
            for line in infile:
                split_lines = line.split(path_to_remove)
                if (path_to_remove!=split_lines[0]):
                    weird_file = line
                    error_log.write(weird_file+'\n')
                    weird_files+=1
                else:    
                    new_line = split_lines[-1]
                    outfile.write(new_line + '\n')
    print("there were "+str(weird_files)+" weird files")

def main(input_prefix, path_to_remove):
    clean_up_paths(input_prefix,path_to_remove)


if __name__ == "__main__":
    if len(sys.argv) !=3:
        print("wrong number of arguments")
        sys.exit(1)
    
    input_file_prefix=sys.argv[1]
    path_to_remove=sys.argv[2]
    main(input_file_prefix,path_to_remove)


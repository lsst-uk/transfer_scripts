import sys
import glob

def main(input_file_prefix, path_to_remove):
    pattern = f"{input_file_prefix}*"
    for input_file in glob.glob(pattern):
        output_file = "new-"+input_file
        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
            for line in infile:
                new_line = line.split(path_to_remove)[-1]
                outfile.write(new_line + '\n')


if __name__ == "__main__":
    if len(sys.argv) !=3:
        print("wrong number of arguments")
        sys.exit(1)
    
    input_file_prefix=sys.argv[1]
    path_to_remove=sys.argv[2]
    main(input_file_prefix,path_to_remove)


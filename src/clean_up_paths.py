import sys
import glob
import pandas as pd

def no_duplicates(file_name):
    output_file = "1-"+file_name
    df = pd.read_csv(file_name,header=None,names=['line'])
    old_size = len(df)
    duplicates = df.duplicated(keep='first')
    no_dup = df[~duplicates]
    new_size = len(no_dup)
    no_dup.to_csv(output_file,index=False,header=False)
    dup_size = old_size-new_size
    print('Found {} duplicates'.format(dup_size))
    return output_file

def weird_paths(file_name, path_to_remove, error_log_name):
    output_file="0-"+file_name
    weird_paths=0
    with open(file_name, 'r') as infile, open(output_file, 'w') as outfile, open(error_log_name, 'w') as error_log:
        for line in infile:
            split_lines = line.split(path_to_remove)
            split_split = split_lines[-1].split('/')
            if(len(split_split)>4): 
                # paths should be tract/patch/band/*.fits
                weird_path = line
                error_log.write(weird_path)
                weird_paths+=1
            else:
                outfile.write(split_lines[-1])
    print("There were {} weird filenames in the list".format(weird_paths))
    return output_file
    # return file_name

def main(file_name, path_to_remove, error_log_name):
    clean_0 = weird_paths(file_name,path_to_remove,error_log_name)
    clean_1 = no_duplicates(clean_0)


if __name__ == "__main__":
    if len(sys.argv) !=4:
        print("wrong number of arguments")
        sys.exit(1)
    
    file_name=sys.argv[1]
    path_to_remove=sys.argv[2]
    error_log_name=sys.argv[3]

    main(file_name,path_to_remove,error_log_name)


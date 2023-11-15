import sys
import glob
import pandas as pd

def no_duplicates_pd(file_name):
    output_file = "no_dup_pd"+file_name
    df = pd.read_csv(file_name,header=None,names=['line'])
    old_size = len(df)
    duplicates = df.duplicated(keep='first')
    no_dup = df[~duplicates]
    new_size = len(no_dup)
    no_dup.to_csv(output_file,index=False,header=False)
    dup_size = old_size-new_size
    print('Found {} duplicates'.format(dup_size))
    return output_file

def no_duplicates(file_path):
    seen_lines = set()
    out_name = 'no_dup_'+file_path
    old_size = 0
    new_size = 0 
    with open(file_path, 'r') as file, open(out_name,'w') as outfile:
        for line in file:
            old_size+=1
            # line = line.strip()  # Remove leading/trailing whitespace
            if line not in seen_lines:
                seen_lines.add(line)
                outfile.write(line)
                new_size+=1
    dup_size = old_size-new_size
    print('Found {} duplicates'.format(dup_size))
    return out_name

def weird_paths(file_name, path_to_remove, error_log_name):
    output_file="clean-"+file_name
    weird_paths=0
    with open(file_name, 'r') as infile, open(output_file, 'w') as outfile, open(error_log_name, 'w') as error_log:
        for line in infile:
            split_lines = line.split(path_to_remove)
            # split_split = split_lines[-1].split('/')
            # if(len(split_split)!=4): 
                # paths should be tract/patch/band/*.fits
                # weird_path = line
                # error_log.write(weird_path)
                # weird_paths+=1
            # else:
            clean_line=split_lines[-1].strip()
                # clean_line = line.strip()
            outfile.write(clean_line+'\n')
    print("There were {} weird filenames in the list".format(weird_paths))
    return output_file
    # return file_name

def clean_up(file_name, path_to_remove, error_log_name):
    output_file = "clean_"+file_name
    weird_paths=0
    with open(file_name, 'r') as infile, open(output_file, 'w') as outfile, open(error_log_name, 'w') as error_log:
        for line in infile:
            line_without_path = line.split(path_to_remove)[-1]
            line_split = line_without_path.split('/')
            line_end = line_split[-1].split('.fits')
            #line should end in .fits
            #path should be patch/tract/band/file after removing path
            if len(line_split)==12 and len(line_end)==2:
                outfile.write(line_without_path)
            else:
                weird_paths+=1
                print('weird: '+line_without_path)
    print("There were {} weird filenames in the list".format(weird_paths))
                

def main(file_name, path_to_remove, error_log_name):
    # clean_0 = no_duplicates_pd(file_name)
    # clean_0 = no_duplicates(file_name)
    #clean_1 = weird_paths(clean_0,path_to_remove,error_log_name)
    clean_1 = clean_up(file_name,path_to_remove,error_log_name)


if __name__ == "__main__":
    if len(sys.argv) !=4:
        print("wrong number of arguments")
        sys.exit(1)
    
    file_name=sys.argv[1]
    path_to_remove=sys.argv[2]
    error_log_name=sys.argv[3]

    main(file_name,path_to_remove,error_log_name)


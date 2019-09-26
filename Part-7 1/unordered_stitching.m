% read all image then store them in dict.
%   the code of Read All Image function reference from
%   [https://www.mathworks.com/matlabcentral/answers/77062-how-to-store-images-in-a-single-array-or-matrix]
%   the author is Azzi Abdelmalek
f=dir('*.jpg');
files={f.name};
for k=1:numel(files)
  Im{k}=imresize(imread(files{k}),0.5);
end

num_images = k;
for i=1:num_images-1
    max_count=0;
    if i ==1
        sti_im = Im{1};
        Im(:,1)=[];
    end
    for k=1:num_images-i
        [H,count]=H_finder(sti_im,Im{k});
        if max_count < count
            max_count = count;
            idx = k;
            best_H = H;
        end
    end
    if max_count > 10
        [sti_im]=stitch(sti_im,Im{idx},best_H);
        % cut the black frame
        [row,col] = find(sum(sti_im,3)~=0);
        sti_im = sti_im(min(row):max(row),min(col):max(col),:);
    end
    Im(:,idx)=[];
end
figure();imshow(sti_im)

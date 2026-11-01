%This function is the implementation of the ISRA image reconstruction
%algorithm. It is used to reconstruct an image from PET-scan data. 

%The input is:
% - InitialImage, a vector [x1 x2 ... xn] guessing the image
% - Data, a vector [y1 y2 ... ym] with all the data collected
% - SystemMatrix, the system matrix. See PET documentation
% - Iterations, the number of iterations
% - Output, if output is required at each iteration

%The output is:
% - Image, a vector [x1 x2 ... xn] the reconstructed image


function [UpdatedImage] = ISRA(InitialImage, Data, SystemMatrix, Iterations, Output)
    UpdatedImage = InitialImage;
    
    A = zeros(1,numel(UpdatedImage));
    
    for j = 1:numel(UpdatedImage)
        for i = 1:numel(Data)
            A(j) = A(j) + SystemMatrix(i,j)*Data(i);
        end
    end
    
    for n = 1:Iterations
        B = zeros(1,numel(UpdatedImage));
        
        for j = 1:numel(UpdatedImage)
            for k = 1:numel(Data)
                for l = 1:numel(UpdatedImage)
                    B(j) = B(j) + SystemMatrix(k,j)*SystemMatrix(k,l)*UpdatedImage(l);
                end
            end
        end
        
        for j = 1:numel(UpdatedImage)
            UpdatedImage(j) = UpdatedImage(j)*A(j)/B(j);
        end
        
        if Output
            for i = 1:numel(UpdatedImage)
                fprintf('x%i = %f\n', i, UpdatedImage(i))
            end
            fprintf('\n')
        end
    end
end
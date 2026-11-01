%This function is the implementation of the MLEM image reconstruction
%algorithm. It is used to reconstruct an image from PET-scan data. 

%The input is:
% - InitialImage, a vector [x1 x2 ... xn] guessing the image
% - Data, a vector [y1 y2 ... ym] with all the data collected
% - SystemMatrix, the system matrix. See PET documentation
% - Iterations, the number of iterations
% - Output, if output is required at each iteration

%The output is:
% - Image, a vector [x1 x2 ... xn] the reconstructed image


function [UpdatedImage] = MLEM(InitialImage, Data, SystemMatrix, iterations, output)
    UpdatedImage = InitialImage;
    
    for n = 1:iterations
        A = zeros(1,numel(Data));
        B = zeros(1,numel(UpdatedImage));
        C = zeros(1,numel(UpdatedImage));
        
        for i = 1:numel(Data)
            for k = 1:numel(UpdatedImage)
                A(i) = A(i)+SystemMatrix(i,k)*UpdatedImage(k);
            end
        end
        
        for j = 1:numel(UpdatedImage)
            for i = 1:numel(Data)
                B(j) = B(j)+SystemMatrix(i,j)*Data(i)/A(i);
            end
        end
        
        for j = 1:numel(UpdatedImage)
             for i = 1:numel(Data) 
                 C(j) = C(j)+SystemMatrix(i,j);
             end
        end
        
        for j = 1:numel(UpdatedImage)
            UpdatedImage(j) = UpdatedImage(j)/C(j)*B(j);
        end
        
        if output
            for i = 1:numel(UpdatedImage)
                fprintf('x%i = %f\n', i, UpdatedImage(i))
            end
            fprintf('\n')
        end
    end
end
%         A = sum(SystemMatrix,1);
% 
%         B = UpdatedImage./A;
% 
%         C = SystemMatrix;
%         for k = 1:size(SystemMatrix,1)
%             for l = 1:size(SystemMatrix,2)
%                 C(k,l) = C(k,l)*UpdatedImage(l);
%             end
%         end
% 
%         D = sum(C,2);
% 
%         E = Data./D;
% 
%         F = SystemMatrix;
%         for k = 1:size(SystemMatrix,1)
%             for l = 1:size(SystemMatrix,2)
%                 F(k,l) = F(k,l)*E(k);
%             end
%         end
% 
%         G = sum(F,1);
% 
%         UpdatedImage = B.*G;
%         
%         if output
%             for i = 1:numel(UpdatedImage)
%                 fprintf('x%i = %f\n', i, UpdatedImage(i))
%             end
%             fprintf('\n')
%         end
%     end
% end
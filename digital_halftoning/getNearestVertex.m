function vertex = getNearestVertex(mbvq, R, G, B)
% getNearestVertex: find nearst vertex in the given MBVQ for a target pixel
% 
% INPUT:
% mbvq (char array): the mbvq the target pixel is related to
% R, G, B (range:0~1): the R, G, B channel value of the target pixel
% 
% OUPUT:
% vertex (char array): the name of the closest vertex
% 
% Ref: "Color Diffusion: Error-Diffusion for Color Halftones
% by Shaked, Arad, Fitzhugh, and Sobel -- HP Labs
% Hewlett-Packard Laboratories TR 96-128
% and Electronic Imaging, Proc. SPIE 3648, 1999
% Adapted from Halftoning Toolbox Version 1.2 released July 2005 (Univ. of Texas)


% No.1 for CMYW
    if (mbvq == 'CMYW')
        vertex = 'white';
        if (B < 0.5)
            if (B <= R)
                if (B <= G)
                    vertex = 'yellow';
                end
            end
        end
        if (G < 0.5)
            if (G <= B)
                if (G <= R)
                    vertex = 'magenta';
                end
            end
        end
        if (R < 0.5)
            if (R <= B)
                if (R <= G)
                    vertex = 'cyan';
                end
            end
        end
    end


% No.2 for MYGC
    if (mbvq == 'MYGC')
        vertex = 'magenta'; 
        if (G >= B)
            if (R >= B)
                if (R >= 0.5)
                    vertex = 'yellow';
                else
                    vertex = 'green';
                end
            end
        end
        if (G >= R)
            if (B >= R)
                if (B >= 0.5)
                    vertex = 'cyan'; 
                else
                    vertex = 'green';
                end
            end
        end
    end


% No.3 for RGMY
    if (mbvq == 'RGMY')
        if (B > 0.5)
            if (R > 0.5)
                if (B >= G)
                    vertex = 'magenta';
                else
                    vertex = 'yellow';
                end
            else
                if (G > B + R)
                    vertex = 'green';
                else 
                    vertex = 'magenta';
                end
            end
        else
            if (R >= 0.5)
                if (G >= 0.5)
                    vertex = 'yellow';
                else
                    vertex = 'red';
                end
            else
                if (R >= G)
                    vertex = 'red';
                else
                    vertex = 'green';
                end
            end
        end
    end


% No.4 for KRGB
    if (mbvq == 'KRGB')
        vertex = 'black';
        if (B > 0.5)
            if (B >= R)
                if (B >= G)
                    vertex = 'blue';
                end
            end
        end
        if (G > 0.5)
            if (G >= B)
                if (G >= R)
                    vertex = 'green';
                end
            end
        end
        if (R > 0.5)
            if (R >= B)
                if (R >= G)
                    vertex = 'red';
                end
            end
        end
    end


% No.5 for RGBM
    if (mbvq == 'RGBM')
        vertex = 'green';
        if (R > G)
            if (R >= B)
                if (B < 0.5)
                    vertex = 'red';
                else
                    vertex = 'magenta';
                end
            end
        end
        if (B > G)
            if (B >= R)
                if (R < 0.5)
                    vertex = 'blue';
                else
                    vertex = 'magenta';
                end
            end
        end
    end


% No.6 for CMGB
    if (mbvq == 'CMGB')
        if (B > 0.5)
            if ( R > 0.5)
                if (G >= R)
                    vertex = 'cyan';
                else
                    vertex = 'magenta';
                end
            else
                if (G > 0.5)
                    vertex = 'cyan';
                else
                    vertex = 'blue';
                end
            end
        else
            if ( R > 0.5)
                if (R - G + B >= 0.5)
                    vertex = 'magenta';
                else
                    vertex = 'green';
                end
            else
                if (G >= B)
                    vertex = 'green';
                else
                    vertex = 'blue';
                end
            end
        end
    end

end %function
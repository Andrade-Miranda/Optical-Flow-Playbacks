#include "opencvmex.hpp"
#include <vector>

using namespace cv;
using namespace std;


//////Global///////////
vector<Mat> OFmag;
/////////////////////////

///////////////////////////////////////////////////////////////////////////
Mat OF_PlayBack(Mat gray1,Mat gray2, int Line,int option);
Mat OF_calculation(Mat Img1, Mat Img2, int option);
////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////
// Check inputs
//////////////////////////////////////////////////////////////////////////////
void checkInputs(int nrhs, const mxArray *prhs[])
{
    if (nrhs != 2)
    {
        mexErrMsgTxt("Incorrect number of inputs. Function expects 2 inputs.");
    }
    
    if (!mxIsUint8(prhs[0]))
    {
        mexErrMsgTxt("Input image must be uint8.");
    }
}



/////////////////////////////////////////////////////////////////////
Mat OF_PlayBack(Mat gray1,Mat gray2, int Line,int option)
{
    Mat Flow;
    Flow=OF_calculation(gray1,gray2,option);
    return(Flow);
}




//////////////////////////////////////////////////////////////////////////////////
Mat OF_calculation(Mat Img1, Mat Img2, int option)
{
    Mat Flow;
    if (option==1)
    {
        Ptr<DenseOpticalFlow> tvl1 = createOptFlow_DualTVL1();
        tvl1->set("nscales",1);// no pyramids, no extra layers
        tvl1->set("lambda",0.15);// default value
        tvl1->set("theta",0.3);// default value
        tvl1->set("warps",5);// default value
        tvl1->set("iterations",100);
        tvl1->calc(Img1,Img2,Flow);
    }else if(option==2)
    {
        // pyr_scale=0.5 -> parameter, specifying the image scale
        // levels=1 -> number of pyramid layers; levels=1 means that no extra layers are created
        // winsize=9 -> averaging window size
        // iterations=1 -> number of iterations the algorithm does at each pyramid level
        // poly_n =7 size of the pixel neighborhood used, typically poly_n =5 or 7.
        // poly_sigma =1.2 – standard deviation of the Gaussian, for poly_n=7, a good value would be poly_sigma=1.5
        // flags = OPTFLOW_FARNEBACK_GAUSSIAN, uses the Gaussian winsizeXwinsize filter instead of a box filter of the same size for optical flow estimation.
        calcOpticalFlowFarneback(Img1,Img2,Flow, 0.5, 1, 9, 1, 7, 1.5,OPTFLOW_FARNEBACK_GAUSSIAN);
    }    return (Flow);
}
//////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////
// The main MEX function entry point
//////////////////////////////////////////////////////////////////////////////
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    Mat Flow_TVL1,Flow_faner;
    
    checkInputs(nrhs, prhs);
    
    // inputs
    cv::Ptr<cv::Mat> gray1 = ocvMxArrayToImage_uint8(prhs[0], true);
    cv::Ptr<cv::Mat> gray2 = ocvMxArrayToImage_uint8(prhs[1], true);
    
    
    
    Flow_TVL1=OF_PlayBack(*gray1,*gray2,50,1);
    Flow_faner=OF_PlayBack(*gray1,*gray2,50,2);
   
     
    // populate the outputs
    plhs[0] = ocvMxArrayFromImage_single(Flow_TVL1);
    plhs[1] = ocvMxArrayFromImage_single(Flow_faner);
}




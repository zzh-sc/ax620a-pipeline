#include "opencv2/opencv.hpp"
#include "../sample_run_joint/sample_run_joint.h"
#include "osd_utils.h"

#include "sstream"

void genImg(int charlen, float fontscale, osd_utils_img *out)
{
    std::stringstream ss;

    for (int i = 0; i < charlen; i++)
    {
        ss << "O";
    }
    std::string text = ss.str();

    int baseLine = 0;
    cv::Size label_size = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, fontscale, 2, &baseLine);

    out->width = label_size.width;
    out->height = label_size.height * 1.5;
    out->channel = 4;
    out->data = new uchar[out->width * out->height * out->channel];
    memset(out->data, 0, out->width * out->height * out->channel);
}

int putText(char *text, float fontscale, osd_utils_img *base, osd_utils_img *out)
{
    int baseLine = 0;
    cv::Size label_size = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, fontscale, 2, &baseLine);
    out->width = label_size.width;
    out->height = label_size.height * 1.5;
    out->channel = 4;

    if (out->width * out->height * out->channel > base->width * base->height * base->channel)
    {
        return -1;
    }
    out->data = base->data;

    memset(out->data, 0, out->width * out->height * out->channel);

    cv::Mat src(out->height, out->width, CV_8UC4, out->data);
    cv::putText(src, text, cv::Point(0, label_size.height), cv::FONT_HERSHEY_SIMPLEX, fontscale, cv::Scalar(255, 0, 0, 255), 2);
}

void releaseImg(osd_utils_img *img)
{
    if (img)
    {
        delete[] img->data;
        memset(img, 0, sizeof(osd_utils_img));
    }
}

void drawObjs(osd_utils_img *out, float fontscale, sample_run_joint_results *results)
{
    cv::Mat image(out->height, out->width, CV_8UC4, out->data);
    for (size_t i = 0; i < results->size; i++)
    {
        cv::Rect rect(results->objects[i].x * out->width,
                      results->objects[i].y * out->height,
                      results->objects[i].w * out->width,
                      results->objects[i].h * out->height);

        cv::rectangle(image, rect, cv::Scalar(255, 0, 0, 255), 2);

        int baseLine = 0;
        cv::Size label_size = cv::getTextSize(results->objects[i].objname, cv::FONT_HERSHEY_SIMPLEX, fontscale, 2, &baseLine);

        int x = rect.x;
        int y = rect.y - label_size.height - baseLine;
        if (y < 0)
            y = 0;
        if (x + label_size.width > image.cols)
            x = image.cols - label_size.width;

        cv::rectangle(image, cv::Rect(cv::Point(x, y), cv::Size(label_size.width, label_size.height + baseLine)),
                      cv::Scalar(255, 255, 255, 255), -1);

        cv::putText(image, results->objects[i].objname, cv::Point(x, y + label_size.height), cv::FONT_HERSHEY_SIMPLEX, fontscale,
                    cv::Scalar(0, 0, 0, 255));
    }
}

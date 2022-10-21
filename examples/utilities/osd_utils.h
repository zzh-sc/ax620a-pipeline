#ifndef _OSD_UTILS_H_
#define _OSD_UTILS_H_
typedef struct _osd_utils_img
{
    unsigned char *data;
    int width, height, channel;
} osd_utils_img;

#ifdef __cplusplus
extern "C"
{
#endif
    void genImg(int charlen, float fontscale, osd_utils_img *out);
    int putText(char *text, float fontscale, osd_utils_img *base, osd_utils_img *out);
    void releaseImg(osd_utils_img *img);
    void drawObjs(osd_utils_img *out, float fontscale, sample_run_joint_results *results);
#ifdef __cplusplus
}
#endif
#endif
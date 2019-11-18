ORG_IMG_NAME = 'org_img.png';
STEG_IMG_NAME = 'steg_img.png';
HIDDEN_IMG_NAME = 'hide.jpg';

TARGET_IMG_SIZE = 512;
HIDDEN_IMG_SIZE = 200;

SUB_BLOCK_SIZE = 8;

target_img = imread(ORG_IMG_NAME);
hidden_img = imread(HIDDEN_IMG_NAME);

target_img = imresize(target_img, [TARGET_IMG_SIZE TARGET_IMG_SIZE]);
hidden_img = imresize(hidden_img, [HIDDEN_IMG_SIZE HIDDEN_IMG_SIZE]);

betas = [];
psnrHidden = [];
psnrTarget = [];

for Beta = 0.001:0.001:0.005
	steg_img = embed_img(target_img, hidden_img, Beta);

	% disp(psnr(target_img, steg_img));

	extHidden = extractHidden(target_img, steg_img, Beta);
	extHidden = imresize(extHidden, [HIDDEN_IMG_SIZE HIDDEN_IMG_SIZE]);

	betas = [betas; Beta];
	psnrTarget = [psnrTarget; psnr(target_img, steg_img)];
	psnrHidden = [psnrHidden; psnr(hidden_img, extHidden)];

	% figure;
	% imshow(hidden_img);

	% figure;
	% imshow(extHidden);

	% disp(psnr(hidden_img, extHidden));
end

plot(betas, psnrHidden);
hold on
plot(betas, psnrTarget);
hold off
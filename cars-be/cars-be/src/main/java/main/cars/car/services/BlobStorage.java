package main.cars.car.services;

import com.azure.core.util.BinaryData;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import com.azure.storage.common.StorageSharedKeyCredential;
import main.cars.config.exception.CarException;
import main.cars.config.exception.CarImportException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

@Service
public class BlobStorage {

    @Value("${blob.account}")
    private String BLOB_ACCOUNT;
    @Value("${blob.pass}")
    private String BLOB_PASS;
    @Value("${blob.container}")
    private String BLOB_CONTAINER;

    private static final Logger LOGGER = LoggerFactory.getLogger(BlobStorage.class);

    public List<String> saveImageToAzure(Long offerId, List<String> fileUrls) {

        List<String> result = new LinkedList<>();

        StorageSharedKeyCredential credential = new StorageSharedKeyCredential(BLOB_ACCOUNT, BLOB_PASS);
        String endPoint = String.format(Locale.ROOT, "https://%s.blob.core.windows.net", BLOB_ACCOUNT);
        BlobServiceClient storageClient = new BlobServiceClientBuilder().endpoint(endPoint).credential(credential).buildClient();

        BlobContainerClient blobContainerClient = storageClient.getBlobContainerClient(BLOB_CONTAINER);
        if (!blobContainerClient.exists()) {
            blobContainerClient.create();
        }

        try {
            int num = 4;
            String format = "jpeg";
            for (String imgUrl: fileUrls) {
                URL url = new URL(imgUrl);
                BufferedImage image = ImageIO.read(url);
                String imgBlobUrl = ++num + "." + format;
                BlobClient client = blobContainerClient.getBlobClient(offerId.toString() + "/" + imgBlobUrl);

                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(image, format, baos);
                InputStream is = new ByteArrayInputStream(baos.toByteArray());

                client.upload(is);

                result.add(imgBlobUrl);

                baos.close();
                is.close();
                client.exists();
            }
        } catch (IOException ex) {
            LOGGER.error("Saving img failed ", ex);
            throw new CarImportException(String.format("Import failed for url %s %s", ex.getMessage(), ex.getCause()));
        }
        return result;
    }


    public BinaryData getImage(Long offerId, String imgPath) {
//blobContainerClient.getBlobClient(offerId.toString() +"/"+ 5 + "." + format).downloadContent()
        //12/5.jpg
        StorageSharedKeyCredential credential = new StorageSharedKeyCredential(BLOB_ACCOUNT, BLOB_PASS);
        String endPoint = String.format(Locale.ROOT, "https://%s.blob.core.windows.net", BLOB_ACCOUNT);
        BlobServiceClient storageClient = new BlobServiceClientBuilder().endpoint(endPoint).credential(credential).buildClient();

        BlobContainerClient blobContainerClient = storageClient.getBlobContainerClient(BLOB_CONTAINER);
        if (!blobContainerClient.exists()) {
            LOGGER.error("Getting img failed container missing");
            throw new CarException("Getting img failed container missing");
        }

        BlobClient client = blobContainerClient.getBlobClient(offerId.toString() +"/"+ imgPath);
        if (!client.exists()) {
            LOGGER.error("Getting img failed container missing");
            throw new CarException("Getting img failed fail missing");
        }
        BinaryData result = client.downloadContent();
        client.exists();
        return result;
    }
}

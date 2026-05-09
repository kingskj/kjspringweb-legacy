package com.kjweb.legacy.web.service;
import com.kjweb.legacy.domain.mapper.LegacyOpsMapper; import com.kjweb.legacy.domain.model.FileManifestLegacy; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import java.io.*; import java.nio.charset.StandardCharsets; import java.util.List;
@Service
public class FileImportService {
    private static final String DROPBOX_DIR="D:/workspace/kjspringweb-legacy/dropbox";
    private final LegacyOpsMapper mapper;
    public FileImportService(LegacyOpsMapper mapper){this.mapper=mapper;}
    public List<FileManifestLegacy> findManifests(){return mapper.findManifests();}
    public void register(String fileName,String expectedRows){mapper.insertManifest(fileName,Integer.valueOf(expectedRows));}
    @Transactional public void process(String id) throws Exception {Long mid=Long.valueOf(id); FileManifestLegacy m=mapper.findManifest(mid); File file=new File(DROPBOX_DIR,m.getFileName()); int rows=0; BufferedReader r=new BufferedReader(new InputStreamReader(new FileInputStream(file),StandardCharsets.UTF_8)); try{while(r.readLine()!=null){rows++;}}finally{r.close();} if(rows!=m.getExpectedRows()){throw new IllegalStateException("row count mismatch expected="+m.getExpectedRows()+" actual="+rows);} mapper.updateManifestStatus(mid,"DONE");}
}
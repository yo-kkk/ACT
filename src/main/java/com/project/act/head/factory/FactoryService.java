package com.project.act.head.factory;

import java.util.List;

import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.PageDTO;

public interface FactoryService {

	List<FactoryDTO> getFactoryList(PageDTO pageDTO) throws Exception;

	void addFactory(FactoryDTO factoryDTO)throws Exception;

	void deleteFactory(FactoryDTO factoryDTO)throws Exception;

	void editFactory(FactoryDTO factoryDTO)throws Exception;

	long get_total_count() throws Exception;


}

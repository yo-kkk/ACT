package com.project.act.head.factory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.PageDTO;

@Service
public class FactoryServiceImpl implements FactoryService{	
	
	@Autowired
	private FactoryDAO factoryDAO;
		
	@Override
	public List<FactoryDTO> getFactoryList(PageDTO pageDTO) throws Exception {
		
		return factoryDAO.getFactoryList(pageDTO);
	}

	@Override
	public void addFactory(FactoryDTO factoryDTO) throws Exception {
		factoryDAO.addFactory(factoryDTO);
		
	}

	@Override
	public void deleteFactory(FactoryDTO factoryDTO) throws Exception {
		factoryDAO.deleteFactory(factoryDTO);
		
	}

	@Override
	public void editFactory(FactoryDTO factoryDTO) throws Exception {
		factoryDAO.editFactory(factoryDTO);
		
	}

	@Override
	public long get_total_count() throws Exception {
		
		return factoryDAO.get_total_count();
	}

}

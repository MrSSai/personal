package cn.knowsbox.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Role extends BaseEntity<Long> {

	private static final Long serialVersionUID = -3802292814767103648L;

	private String name;

	private String description;


}

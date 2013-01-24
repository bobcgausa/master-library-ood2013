package reuze.awt;

import com.software.reuze.ib_a_FilterTransfer;
/*
Copyright 2006 Jerry Huxtable

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

public class ib_FilterExposure extends ib_a_FilterTransfer {

	private float exposure = 1.0f;

	protected float transferFunction( float f ) {
		return 1 - (float)Math.exp(-f * exposure);
	}

	public void setExposure(float exposure) {
		this.exposure = exposure;
		initialized = false;
	}
	
	public float getExposure() {
		return exposure;
	}

	public String toString() {
		return "Colors/Exposure...";
	}

}

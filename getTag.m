function ans= getTag(test, testId, X, F, N)
	K = 50;

	tagFreq = 1 ./ sum(X{F+1}, 2);
	tagFreq(sum(X{F+1}, 2)==0) = 0;
	
	

	W = zeros(N);
	for i=1:N
		W(i,i) = sum( (X{F+1}(:,i))' * tagFreq);
	end

	W2 = W * W';

	for f=1:F+1
		Mf = size(X{f})(1);
		U{f} = rand(Mf, K);
		V{f} = rand(N, K);
		Vstar = rand(N, K);

		if f<=F
			T{f} = eye(Mf);
		else
			T{f} = zeros(Mf);
			for i=1:Mf
				T{f}(i,i) = tagFreq(i);
			end
		end

		T2{f} = (T{f})' * T{f};
	end


	lambda = ones(1, F+1) * 0.01;
	lambda(F+1) = 1;



	STEPS = 50;
	for x = 1:STEPS

		for f = 1:F+1

			Mf = size(X{f})(1);

			oneMfN = ones(Mf, N);
			oneMfMf = ones(Mf);

			a = T2{f} * X{f} * W2 * V{f};
			b = T2{f} * U{f} * (V{f})' * W2 * V{f};

			Uupdate = (a + lambda(f) * oneMfN * W2 * (V{f} .* Vstar)) ./ \
					  (b + lambda(f) * \
					 ((oneMfMf * U{f}) .* (oneMfN * W2 * (V{f} .^ 2) )));

			U{f} = U{f} .* Uupdate;

			%-------------------------------------

			sumU = sum(U{f});
			Q{f} = zeros(K);
			for i = 1:K
				Q{f}(i, i) = sumU(i);
			end

			U{f} = U{f} * inv(Q{f});
			V{f} = V{f} * Q{f};

			%-------------------------------------

			a = W2 * (X{f})' * T2{f} * U{f};
			b = W2 * V{f} * (U{f})' * T2{f} * U{f};

			Vupdate = (a + lambda(f) * W2 * Vstar) ./ \
					(b + lambda(f) * W2 * V{f});

			V{f} = V{f} .* Vupdate;
		end


		Vstar = zeros(N, K);
		for f = 1:F+1
			Vstar = Vstar + lambda(f) * W2 * V{f};
		end
		Vstar = inv(sum(lambda) * W2) * Vstar;


		tmp = loss(X, T, W, U, V, Q, F, lambda, Vstar);
	end


	v = zeros(K, 1);
	for f = 1:F
		v = v + GPSR_BB( (test{f}(testId,:))', U{f}, 0.1, 'verbose', 0);
	end

	v = v / F;
	x = U{F+1} * v;
	[tmp, idx] = sort(x, 'descend');

	ans = 0;
	for i=1:5
		if (test{F+1}(testId, idx(i))==1)
			ans++;
		end
	end
	
end

function ret = loss(X, T, W, U, V, Q, F, lambda, Vstar)
	ret = 0;
	for f = 1:F+1
		ret = ret + norm( (T{f} * (X{f} - U{f} * (V{f})') * W) , 'fro') + \
			  lambda(f) * norm(W' * (V{f} - Vstar), 'fro');
	end
end

